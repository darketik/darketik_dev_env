# C language coding guidelines for pro embedded FW dev

## Architecture FW embedded

Architecture handles + views + services

- Handles globaux ? seulement au top
- Views passées aux fonctions
- Services purs (sans état global)

## Peripheral HAL construction

### About volatile attribute

### About "u" suffixe for macro declaration

Regle d'or: Tout ce qui touche aux registres doit être explicitement unsigned.

## Memory map construction

### About associating memmap HW address to a FW handle

```#define SEG_ADDR_XGA_CTRL 0x3200

ddg_xga_mgt_handle_t * const ddg_xga_mgt_handle =
    (ddg_xga_mgt_handle_t *)SEG_ADDR_XGA_CTRL;
```

Pourquoi MISRA râle:
SEG_ADDR_XGA_CTRL ? entier
Cast explicite vers ddg_xga_mgt_handle_t *
Conversion entier ? pointeur

#### Utiliser uintptr_t (CRITIQUE)

Ne jamais caster directement un int vers un pointeur.

? À éviter
(ddg_xga_mgt_handle_t *)0x3200
  
? À faire
#define SEG_ADDR_XGA_CTRL   ((uintptr_t)0x3200U)

ddg_xga_mgt_handle_t * const ddg_xga_mgt_handle =
    (ddg_xga_mgt_handle_t *)SEG_ADDR_XGA_CTRL;


?? Pourquoi ?

uintptr_t est le seul type entier prévu pour contenir un pointeur

MISRA accepte cette forme comme déviation contrôlée

#### Marquer la zone comme volatile

Très important en HW :

typedef volatile ddg_xga_mgt_handle_t ddg_xga_mgt_hw_t;

#define XGA_MGT   ((ddg_xga_mgt_hw_t *)SEG_ADDR_XGA_CTRL)

#### Variante encore plus clean : struct + instance unique

typedef struct
{
    uint32_t ctrl;
    uint32_t status;
    uint32_t cfg;
} ddg_xga_mgt_regs_t;

#define XGA_MGT   ((volatile ddg_xga_mgt_regs_t *)SEG_ADDR_XGA_CTRL)

##### pourquoi on utilise une macro

Avantages de la macro
#define XGA_MGT ((volatile ddg_xga_mgt_regs_t *)SEG_ADDR_XGA_CTRL)


? Zéro octet en RAM
? Zéro init (.data / .bss)
? Accès direct, inline
? Standard en bare-metal / CMSIS

?? Pour un micro sans MMU, cest parfait techniquement.

Pourquoi cest moche
Pas de scope
Pas de typage fort visible
Pas de point darrêt objet
Sensation de tricher avec le langage
?? Ton intuition est exacte du point de vue architecture logicielle.

##### Fausse bonne idée : la variable globale
volatile ddg_xga_mgt_regs_t * const xga_mgt = XGA_MGT;


? Occupe de la RAM
? Initialise en .data
? Pointeur stocké inutilement

? À éviter sur une cible contrainte.

##### Solution PROPRE sans coût RAM (recommandée)
?? static inline accessor
?? Cest le meilleur compromis
static inline volatile ddg_xga_mgt_regs_t * xga_mgt(void)
{
    return (volatile ddg_xga_mgt_regs_t *)SEG_ADDR_XGA_CTRL;
}


Utilisation :

xga_mgt()->ctrl = 1U;

?? Génère exactement le même code que la macro

##### Variante encore plus propre : namespace HAL

static inline volatile ddg_xga_mgt_regs_t * XGA_MGT(void)
{
    return (volatile ddg_xga_mgt_regs_t *)SEG_ADDR_XGA_CTRL;
}


Lecture claire :

XGA_MGT()->status;

##### approche unifiee

On va faire ça proprement, cohérent, MISRA-clean, et surtout scalable pour tout ton HAL bare-metal RISC-V.

Je te propose un pattern dunification complet, tel quon le retrouve dans des HAL industriels (ST, NXP, automotive, etc.), mais sans lourdeur inutile.

Objectif
0 octet en RAM
Accès HW typés
Conversion pointeur ? entier unique et justifiée
API lisible
Compatible MISRA-C:2012
Facile à auditer

###### Organisation des fichiers (clé)

hal/
+-- soc/
¦   +-- soc_memory_map.h        // adresses brutes
¦   +-- soc_types.h             // types communs
¦
+-- xga/
¦   +-- xga_regs.h              // layout registres
¦   +-- xga_hw.h                // accessors HW (inline)
¦   +-- xga_hal.h               // API HAL publique
¦
+-- hal_common.h

Memory map centralisée (UNE SEULE FOIS)

?? soc_memory_map.h

#ifndef SOC_MEMORY_MAP_H
#define SOC_MEMORY_MAP_H

#include <stdint.h>

/* MISRA deviation:
 * Rule 11.4  integer to pointer conversion
 * Justification: HW memory mapped registers
 */
#define SEG_ADDR_XGA_CTRL   (0x3200u)

#endif

Accessor HW (? cur du pattern)

?? xga_hw.h

#ifndef XGA_HW_H
#define XGA_HW_H

#include <stdint.h>
#include "soc_memory_map.h"
#include "xga_regs.h"

static inline volatile xga_regs_t * xga_hw(void)
{
    return (volatile xga_regs_t *)(uintptr_t)SEG_ADDR_XGA_CTRL;
}

#endif

HAL public (API métier)

?? xga_hal.h

#ifndef XGA_HAL_H
#define XGA_HAL_H

#include <stdint.h>

static inline void XGA_Enable(void)
{
    xga_hw()->CTRL |= 0x1u;
}

static inline uint32_t XGA_GetStatus(void)
{
    return xga_hw()->STATUS;
}

static inline void XGA_SetCfg(uint32_t cfg)
{
    xga_hw()->CFG = cfg;
}

#endif

Utilisation côté application
#include "xga_hal.h"

void app_init(void)
{
    XGA_Enable();

    if (XGA_GetStatus() & READY_FLAG)
    {
        XGA_SetCfg(0x42u);
    }
}

###### Règles de style (à écrire noir sur blanc)

?? Charte HAL

? Pas de pointeur global vers du HW

? Pas de macros daccès aux registres

? Un accessor static inline par IP

? Conversion adresse ? pointeur uniquement dans *_hw.h

? Registres uniquement via HAL public

? Suffixe _hw() réservé HW pur

? volatile uniquement dans la couche registre

### About "u" suffixe for macro declaration

Regle d'or: Tout ce qui touche aux memmap doit être explicitement unsigned.

## Tips & Tricks

### How to use const in functions arguments

La règle devient simple dès qu'on sépare 3 choses différentes :

- Ce que tu passes (valeur vs pointeur)
- Ce que la fonction a le droit de modifier
- Ce que const protège réellement

Je vais te donner une grille de lecture systématique, puis des exemples proches de ton firmware RISC-V.

1. Règle fondamentale (à graver)

const s'applique toujours à ce qui est immédiatement à gauche
(s'il n'y a rien à gauche, il s'applique à droite)

const T * p   =   T const * p

Ça veut dire : ce que pointe p est const

Usage fondamentaux:

- Pointeur vers donnée modifiable
  - void f(int * p);
- Pointeur vers donnée constante (le plus courant)
  - void f(const int * p); 

### Surconsommation mémoire à cause des uint8_t isolés

Exemple typique :

uint8_t smearing_ena;
uint16_t smearing_y_start;
uint16_t smearing_y_size;
uint8_t strobe_polarity;
uint8_t strobe_mode;


Sur une cible 32 bits (RISC-V Ibex par ex) :

alignement = 32 bits

beaucoup de padding implicite

?? Résultat :
?? tu perds souvent plus de mémoire que tu ne crois

?? Recommandation

Regrouper les flags :

struct {
  uint8_t smearing_ena : 1;
  uint8_t strobe_polarity : 1;
  uint8_t strobe_mode : 2;
  uint8_t shutter_polarity : 1;
  uint8_t shutter_mode : 2;
  uint8_t reserved : 1;
} flags;

### Structures très larges = mauvais cache / bus

Certaines structs sont énormes :

ddg_vtss_fw_kernel_static_handle_t

ddg_vtss_fw_kernel_expo_internal_handle_t

Si :

certaines parties sont rarement utilisées

ou utilisées seulement dans certains IRQ

?? Tu pourrais splitter :

struct ddg_vtss_fw_kernel_static_handle_t {
  common;
  debug;
  analog;
};


ou mieux :

ddg_vtss_fw_kernel_static_core_t
ddg_vtss_fw_kernel_static_debug_t


? Avantage :

meilleure localité mémoire

moins de pollution cache

IRQ plus rapides

### Nommage très long mais peu hiérarchique

Exemple :

ddg_vtss_fw_kernel_readout_internal_expo_handle_struct_t


Lisible, mais très lourd cognitivement.

?? En FW embarqué complexe, une convention type :

vtss_ro_ih_expo_t
vtss_expo_ih_t
vtss_static_h_t


préfixe fichier/module

?? Améliore fortement la lisibilité sans perdre la précision.

### Pas de packing contrôlé

Tu dépends implicitement de l'ABI.

Si ces structs sont :

mappées sur HW

envoyées à un autre core

utilisées en dump/debug

?? Ajoute explicitement :

static_assert(sizeof(...) == expected);


ou :

__attribute__((packed, aligned(4)))


?? uniquement si nécessaire (packing peut coûter en perf).

### Le problème que tu as aujourd'hui (sans t'en rendre compte)

Actuellement, beaucoup de fonctions reçoivent soit :

ddg_vtss_fw_handle_t *

soit directement ddg_vtss_fw_kernel_expo_handle_t *

et via ces pointeurs, elles ont accès à énormément de choses :

keh->kehi->under_process = 0;
keh->ksh->y_flip = 1;
keh->pec->strobe_start = 123;


?? Rien n'empêche une fonction de :

modifier un champ qu'elle ne devrait pas

toucher à du static alors qu'elle est appelée en IRQ

casser une invariance entre Expo / Readout

écrire dans next au lieu de curr

?? Le compilateur ne peut pas t'aider à éviter ça.

#### L'idée clé d'une view (ou context)

Une view, c'est :

un sous-ensemble volontairement restreint de pointeurs, avec des const qui expriment ce qu'une fonction a le droit de faire.

Exemple que j'ai donné :

typedef struct {
  const ddg_vtss_fw_kernel_static_handle_t * ksh;
  const ddg_vtss_fw_kernel_expo_handle_t * keh;
} vtss_expo_ctx_t;


?? Cette structure ne contient :

que ce qui est utile

dans l'état exact où la fonction doit l'utiliser

#### Plusieurs views selon le rôle
?? View lecture seule Expo (IRQ)
typedef struct {
  const ddg_vtss_fw_kernel_static_handle_t * ksh;
  const ddg_vtss_fw_kernel_expo_handle_t * keh;
} vtss_expo_ro_ctx_t;

?? View modification interne Expo
typedef struct {
  const ddg_vtss_fw_kernel_static_handle_t * ksh;
  ddg_vtss_fw_kernel_expo_internal_handle_t * kehi;
} vtss_expo_rw_ctx_t;

?? View Readout uniquement
typedef struct {
  const ddg_vtss_fw_kernel_readout_handle_t * krh;
} vtss_readout_ctx_t;


?? Chaque fonction reçoit exactement ce dont elle a besoin.

### Principes fondamentaux (à internaliser)

Ces règles sont communes à tous les très bons FW bare-metal.

?? 1. Tout état doit avoir un propriétaire clair

Un seul module écrit

Les autres lisent via une view

Pas d'état global libre service

?? C'est exactement ce que tu fais déjà, mais les views rendent ça formel.

?? 2. Le compilateur est ton meilleur outil de vérification

Tu dois chercher à :

transformer des bugs runtime en erreurs de compilation

utiliser :

const

types dédiés

static_assert

enums fermés

Si le compilateur peut t'empêcher de faire une bêtise, laisse-le faire.

?? 3. Zéro magie implicite

En bare-metal :

pas de dépendances cachées

pas de side effects silencieux

pas d'ordre d'appel implicite

Chaque fonction doit clairement dire :

ce qu'elle lit

ce qu'elle modifie

quand


## Gestion des IRQ dans un FW embarqué
dans un fw embarque s'executant sur un cpu riscv avec un controleur d'IRQ sans preemption mais avec gestion priorite fixe, quelle est la meilleure strategie de gestion des IRQ pour un fw reactif:
- executer les actions dans le handler d'irq
- lever rapidement un flag dans le handler d'irq et gerer les actions dans la boucle principale

Et comment gerer ces variables d'etat fw que sont le flag d'irq

Très bonne question  cest exactement le genre de sujet où une petite décision darchitecture fait une énorme différence sur la réactivité et la robustesse du FW ??
Je te réponds de façon pragmatique, orientée RISC-V bare-metal / Ibex-like, IRQ sans préemption, priorité fixe.

TL;DR (si tu veux la règle dor)

?? ISR ultra-courte
?? Pas de logique métier dans lISR
?? ISR = capture + signalisation
?? Traitement dans le main loop / scheduler coopératif

1?? Exécuter laction dans le handler dIRQ ? (mauvaise idée en général)
Avantages

Latence minimale pour cet événement précis

Code parfois simple pour des cas triviaux

Inconvénients (et ils sont lourds)

? Bloque toutes les IRQ de priorité inférieure

? Jitter non maîtrisé

? ISR difficile à auditer / tester

? Risque deffet domino (une ISR longue retarde tout)

? Très mauvaise évolutivité quand le FW grossit

?? Sur un contrôleur non préemptif, cest encore pire :
une ISR longue = système figé pendant toute sa durée.

?? À réserver uniquement à :

acquittement HW

lecture dun registre

sauvegarde dun timestamp

déclenchement dun mécanisme FW

2?? Lever un flag et traiter dans la boucle principale ? (bonne pratique)

Cest la stratégie recommandée dans ton contexte.

Pourquoi cest la meilleure ?

? ISR déterministe et très courte

? Meilleure maîtrise des priorités

? Code métier hors contexte IRQ

? Débogage et tests facilités

? Scalabilité (ajout dIRQ sans casser lexistant)

?? Tu transformes ton FW en système événementiel coopératif

3?? La vraie bonne architecture : ISR ? Event ? Traitement
3.1 Ce que fait lISR (strict minimum)
void timer_irq_handler(void)
{
    TIMER->IRQ_CLEAR = 1;      // ack HW
    fw_events |= EVT_TIMER;    // signal logiciel
}


ISR = ACK + SIGNAL
Rien dautre.

3.2 Traitement dans la boucle principale
int main(void)
{
    while (1) {
        uint32_t events = fw_events;

        if (events & EVT_TIMER) {
            fw_events &= ~EVT_TIMER;
            handle_timer();
        }

        if (events & EVT_UART_RX) {
            fw_events &= ~EVT_UART_RX;
            handle_uart_rx();
        }
    }
}


?? Priorité logique gérée ici, indépendamment du HW.

4?? Gestion propre des flags dIRQ (point clé ??)
4.1 volatile obligatoire
volatile uint32_t fw_events;


Sinon :

optimisations du compilateur ?

lecture mise en cache ?

comportement indéfini ?

4.2 Problème classique : race condition

?? Cas dangereux :

ISR modifie fw_events

main loop lit + efface en même temps

Solution 1?? (simple et robuste)

Section critique courte :

disable_irq();
uint32_t events = fw_events;
fw_events = 0;
enable_irq();


Puis traitement hors section critique.

Solution 2?? (plus fine)

Un flag par IRQ (bitmask)
Effacement bit par bit après traitement.

Solution 3?? (pro)

Event queue / ring buffer

typedef enum {
    EVT_TIMER,
    EVT_UART_RX,
    EVT_DMA_DONE,
} fw_event_t;


ISR :

push_event(EVT_TIMER);


Main :

while (pop_event(&evt)) {
    dispatch(evt);
}


? Aucun événement perdu
? Ordre conservé
? Très scalable

5?? Et la réactivité alors ?

?? La latence dépend de :

durée maximale dune ISR (doit être minuscule)

fréquence de passage dans la main loop

?? Astuce classique :

découper les traitements longs en state machines

jamais de while(long) dans le main

6?? Cas particuliers où agir dans lISR est OK

? Clear IRQ HW
? Lire un FIFO pour éviter overflow
? Copier un mot critique en RAM
? Timestamping précis (cycle counter)

Mais pas :

parsing

calcul lourd

accès drivers complexes

logique applicative

7?? Résumé final
Élément	Recommandation
ISR	Ultra courte
Logique métier	? dans ISR
Communication ISR ? FW	Flags / events
Flags	volatile + section critique
Scalabilité	Event queue
Réactivité globale	Excellent

Si tu veux, je peux te proposer :

un mini scheduler coopératif

un framework devents type tiny-RTOS sans RTOS

un exemple Ibex + PLIC / CLIC concret

Dis-moi ??

dans mon cas j'ai certaines irq ou je dois etre sur que le fw associé soit executé en totalité avant l'execution d'une autre irq

Parfait, là on rentre dans le vrai sujet ??
Et ta contrainte change un peu la réponse mais pas autant quon pourrait le croire.

Tu veux donc :

certaines IRQ critiques dont le traitement FW doit être exécuté entièrement avant que toute autre IRQ ne puisse interférer.

Sur un CPU RISC-V sans préemption, à priorité fixe, cest tout à fait gérable proprement, sans retomber dans des ISR monstrueuses.

1?? Clarifions ce que exécuté en totalité veut dire

Il y a en pratique 3 niveaux possibles :

A. Aucune autre IRQ ne doit interrompre ce traitement

? exclusion temporaire des IRQ

B. Les autres IRQ peuvent arriver mais ne doivent pas être traitées

? elles sont déférées

C. Lordre logique doit être respecté

? traitement séquentiel garanti, pas forcément IRQ masquées

?? Les solutions diffèrent selon le niveau exact.
Dans 90 % des FW, B ou C suffisent.

2?? Mauvaise solution (tentante mais dangereuse) ?

« Je fais tout dans lISR et je suis sûr que personne ne minterrompt »

Ça marche jusquau jour où :

tu ajoutes une IRQ plus prioritaire

le traitement grossit

tu introduis du jitter incontrôlable

tu bloques une IRQ temps réel plus critique

?? À éviter sauf cas hardware très spécifiques.

3?? La bonne stratégie : traitement atomique côté FW
Principe clé

?? LISR reste courte
?? La garantie en totalité est faite côté FW, pas côté HW

4?? Stratégie recommandée (robuste & scalable)
4.1 Classification des IRQ

Tu les classes explicitement :

typedef enum {
    IRQ_CLASS_CRITICAL,
    IRQ_CLASS_NORMAL,
    IRQ_CLASS_DEFERRED,
} irq_class_t;

4.2 ISR = signalisation + éventuellement masquage
void critical_irq_handler(void)
{
    IRQ_ACK();
    fw_events |= EVT_CRITICAL;
}

4.3 Traitement critique atomique côté main
void handle_critical_event(void)
{
    disable_irq();     // exclusion globale courte
    // ---- début section critique ----
    do_critical_fw();
    // ---- fin section critique ----
    enable_irq();
}


? Garantie absolue
? ISR courte
? Lisible
? Testable

?? Important :
La section IRQ-masked doit être la plus courte possible.

5?? Variante plus fine : masquage sélectif des IRQ

Si ton contrôleur le permet (PLIC / CLIC):

void handle_critical_event(void)
{
    mask_lower_priority_irqs();
    do_critical_fw();
    unmask_lower_priority_irqs();
}


? Les IRQ plus prioritaires restent actives
? Zéro latence pour lIRQ vraiment critique
? Très propre sur RISC-V CLIC

6?? Variante élégante : critical task lock

Très utilisée en FW industriels ??

volatile bool critical_fw_running;


ISR non critique :

void uart_irq_handler(void)
{
    IRQ_ACK();
    if (!critical_fw_running) {
        fw_events |= EVT_UART;
    } else {
        fw_deferred |= EVT_UART;
    }
}


Main loop :

void handle_critical_event(void)
{
    critical_fw_running = true;
    do_critical_fw();
    critical_fw_running = false;

    fw_events |= fw_deferred;
    fw_deferred = 0;
}


? Aucun masquage IRQ
? Latence minimale
? Ordonnancement FW explicite
? Très scalable

7?? Le pattern recommandé (propre)

Pour chaque IRQ critique :

Étape	Où	Règle
ACK HW	ISR	immédiat
Capture data	ISR	optionnel
Ordre & priorité	FW	explicite
Exécution atomique	FW	garantie
IRQ masking	FW	ciblé et court
8?? Comment choisir la bonne méthode ?
Utilise disable_irq() si :

traitement court

atomicité stricte requise

peu dIRQ

Utilise masquage sélectif si :

IRQ vraiment temps réel

PLIC / CLIC bien maîtrisé

Utilise lock FW si :

FW complexe

beaucoup dIRQ

besoin dévolutivité

9?? Phrase clé à garder en tête ??

Les ISR gèrent le matériel.
Le FW gère les garanties dexécution.

Si tu veux, au prochain message je peux :

te proposer une architecture type Ibex + CLIC

dessiner un diagramme IRQ ? events ? tasks

te donner un template C prêt à intégrer

Dis-moi ce qui taiderait le plus ??

d'ou viennent les fonctions push_event et pop_event

Excellente question ??
Et tu fais bien de la poser, parce que push_event / pop_event ne sont pas magiques : ce sont juste des primitives FW que toi définis.

Je texplique doù elles viennent, ce quelles font, et comment les implémenter proprement dans un FW RISC-V bare-metal.

1?? Ce que représentent push_event() / pop_event()

Ce sont simplement :
?? une file dévénements (event queue)
?? utilisée pour découpler IRQ ? traitement FW

Schéma mental :

IRQ --> ISR --> push_event()
                    |
                    v
            +----------------+
            | Event Queue    |
            +----------------+
                    |
                    v
              pop_event()
                    |
                    v
               handle_event()


Aucune dépendance OS / RTOS.

2?? Pourquoi ne pas utiliser juste des flags ?

Les flags suffisent si :

peu dIRQ

pas dordre important

pas de répétition rapide

Mais une queue dévénements apporte :

? pas de perte dévénement

? ordre conservé

? plusieurs occurrences possibles

? meilleure maîtrise des priorités FW

3?? Implémentation minimale dune event queue (ring buffer)
3.1 Type dévénement
typedef enum {
    EVT_TIMER,
    EVT_UART_RX,
    EVT_DMA_DONE,
    EVT_CRITICAL,
    EVT_MAX
} fw_event_t;

3.2 Structure de la queue
#define EVENT_QUEUE_SIZE 8

typedef struct {
    fw_event_t buf[EVENT_QUEUE_SIZE];
    volatile uint8_t head;
    volatile uint8_t tail;
} event_queue_t;

static event_queue_t evtq;


?? volatile obligatoire car modifié en ISR.

4?? push_event()  appelée depuis lISR

Objectif :

rapide

non bloquante

déterministe

bool push_event(fw_event_t evt)
{
    uint8_t next = (evtq.head + 1) % EVENT_QUEUE_SIZE;

    if (next == evtq.tail) {
        // queue pleine ? politique à définir
        return false;
    }

    evtq.buf[evtq.head] = evt;
    evtq.head = next;
    return true;
}


?? Politique possible si pleine :

drop silencieux

overwrite oldest

set flag EVT_OVERFLOW

incrémenter un compteur debug

5?? pop_event()  appelée dans le main loop
bool pop_event(fw_event_t *evt)
{
    if (evtq.head == evtq.tail) {
        return false; // queue vide
    }

    *evt = evtq.buf[evtq.tail];
    evtq.tail = (evtq.tail + 1) % EVENT_QUEUE_SIZE;
    return true;
}

6?? Problème subtil : concurrence ISR ? main

Tu as deux choix :

Option A?? (simple et sûr)

Section critique courte côté main :

disable_irq();
bool ok = pop_event(&evt);
enable_irq();


? sûr
? simple
? coût négligeable

Option B?? (lock-free SPSC)

Valide si :

ISR = seul producteur

main = seul consommateur

Dans ce cas, le code plus haut est déjà sûr
?? pattern Single Producer / Single Consumer

?? Cest ton cas typique en FW bare-metal.

7?? Et pour garantir quun event critique sexécute en totalité ?

Tu combines event queue + priorité FW :

while (1) {
    fw_event_t evt;

    if (!pop_event(&evt)) {
        idle();
        continue;
    }

    if (evt == EVT_CRITICAL) {
        handle_critical_event();   // peut masquer IRQ
    } else {
        handle_event(evt);
    }
}


Ou même :

queue séparée pour événements critiques

ou traitement immédiat avant toute autre pop

8?? Variante très utilisée : queue + state machine

Pour éviter les traitements longs :

void handle_critical_event(void)
{
    critical_state = CRIT_START;
}

void critical_task_step(void)
{
    switch (critical_state) {
        case CRIT_START:
            ...
            critical_state = CRIT_STEP1;
            break;
        case CRIT_STEP1:
            ...
            critical_state = CRIT_DONE;
            break;
    }
}


Appelé à chaque tour de main.

? zéro blocage
? latence maîtrisée
? temps réel friendly

9?? En résumé
Élément	Rôle
push_event()	ISR ? signal FW
pop_event()	main ? consommer
Event queue	ordre + robustesse
Implémentation	ring buffer SPSC
IRQ longues	?
Atomicité FW	côté main

Si tu veux, je peux te fournir :

un module event_queue.c/.h prêt à drop-in

une version avec priorités FW

une version CLIC / PLIC aware

Dis-moi ce que tu préfères ??

il n'y a pas dans newlib ou stdlib un type queue et une api standardisee

Réponse courte : non ??
Réponse utile : et cest volontaire.

1?? Pourquoi il ny a PAS de queue standard en stdlib / newlib
Le standard C (ISO C)

Le C standard fournit :

mémoire (malloc/free)

chaînes

math

I/O abstrait

? Aucune structure de données :

pas de queue

pas de liste

pas de map

pas de ring buffer

?? Le comité C a délibérément évité :

toute notion de concurrence

toute hypothèse temps réel

toute politique dallocation

newlib

newlib est :

une implémentation de la libc

orientée systèmes embarqués

dépendante de lOS ou du bare-metal

Mais :

? pas de conteneurs

? pas de thread-safe queue

? pas dAPI ISR-safe

Pourquoi ?

newlib ne sait pas si tu as :

un RTOS

des IRQ

du SMP

du cache

donc aucune API universelle possible

2?? POSIX ? Toujours non (dans ton cas)

POSIX propose :

mq_* (message queues)

pthread_*

Mais :

? pas dans newlib bare-metal

? pas ISR-safe

? trop lourds

? non déterministes

3?? Et C++ STL alors ? (spoiler : non plus)

std::queue :

? allocation dynamique

? non déterministe

? pas ISR-safe

? dépend de new/delete

?? totalement inadapté à un FW IRQ-driven.

4?? Ce qui existe quand même (mais hors libc)
A. Linux kernel (exemple, pas pour toi)

kfifo

list_head

workqueue

Très bien mais non portable bare-metal.

B. CMSIS (ARM)

osMessageQueue*

Mais :

dépend dun RTOS

ARM-only

pas RISC-V bare-metal

5?? La réalité en FW embarqué

?? Chaque projet définit ses propres primitives :

event queue

ring buffer

mailbox

deferred work

Pourquoi ?

contraintes temps réel spécifiques

IRQ vs main

mémoire statique

priorités explicites

?? En fait, ce que tu fais là, cest exactement ce que font :

Zephyr

FreeRTOS

Linux kernel
 mais en version minimaliste et maîtrisée.

6?? Bonne nouvelle : il y a des patterns standard

Même si lAPI nest pas standardisée, les patterns le sont :

Pattern SPSC ring buffer (le tien)

1 producteur (ISR)

1 consommateur (main)

lock-free

déterministe

Utilisé partout :

drivers Linux

RTOS

DSP

FW safety-critical

7?? Ce que je te recommande concrètement
? Implémente ton propre module

event_queue.h/.c

mémoire statique

aucune allocation

API minuscule

bool event_push(event_t e);
bool event_pop(event_t *e);
bool event_is_empty(void);

? Documente clairement

ISR-safe

SPSC

non bloquant

politique overflow

8?? Phrase clé à retenir ??

Il ny a pas de queue standard en C embarqué
parce quil ny a pas UNE seule bonne queue.

Si tu veux, au prochain message je peux :

te montrer une implémentation certifiable (MISRA-friendly)

comparer queue vs flags vs mailboxes

te donner un exemple exactement adapté à Ibex / RISC-V

## ref books

- Embedded Software Design  Jack Ganssle

- Programming Embedded Systems: With C and GNU Development Tools

par Michael Barr & Anthony Massa

considéré comme un classique d'introduction et de bonnes pratiques en embarqué.

Traite de périphériques, interruptions, mémoire, optimisation, etc. 
barrgroup.com

- Embedded C Coding Standard  Michael Barr

un coding standard concis ( 8690 pages) écrit par Barr Group.

donne des règles pratiques pour réduire les bugs en C embarqué (naming, types, macros, etc.).

## Modern C++ for embedded FW

### sources

	https://www.educative.io/courses/embedded-programming-with-cpp/embedded-programming-and-cpp
	https://www.etlcpp.com/
	https://www.state-machine.com/doc/PSiCC2.pdf
	https://cppcat.com/c-design-patterns-for-embedded/
  https://www.embeddedrelated.com/showarticle/1532.php



### Avantages réels par rapport au C

- encapsulation forte (invariants garantis)
-constructeurs (initialisation sûre)
- types forts (struct, enum class)
- namespaces
- constexpr
- RAII sans heap

Tout ça sans aucun coût runtime si bien utilisé.

En réalité :
le C++ bien utilisé produit souvent un code ASM plus propre que le C.

### A eviter

-fno-exceptions -fno-rtti

### ref books

https://www.oreilly.com/library/view/embedded-programming-with/9781838821043/



?? Embedded C++  Michael Barr

?? LA référence.

sous-ensemble C++ safe

conventions

linkers

ISR

pas de bullshit

?? Real-Time C++  Christopher Kormanyos

Très bon pour :

bare-metal

no-heap

constexpr

templates légers

?? CppCoreGuidelines (section Embedded)

Auteurs : Stroustrup + communauté

?? À lire en filtrant :

lifetime

const

ownership

pas de STL dynamique

## FW verification

### Stack overflow

Implement a stack overflow checker in RTL DV
