# Various Pyx hidden commands

* *whichproj* - list all existing projects

# Current Dig project management approach

## Create new project for digital design with script *digital_create_project_dir.sh*

## Create new user for an existing project instance for digital design with script *digital_create_project_dir.sh*

### Docs infos utiles

* I:\ISO activities\PROJETS\SPHINX\SPHINX C040\DESIGN\Digital design\procedure_creation_compte_circuit.docx
* \\\VM-MAIN\iso\ISO activities\DIGITAL\Methodologie\gestion\creation_compte_projet_digital.pdf
* Dans pyxcaxxxx/Frontend
  * *digital_create_project_dir.sh* script

## Structure projet DIG

### Doc infos utiles

* "X:\TECH\PYX-QP-DC-19-03-B_accueil_technique.docm - Raccourci.lnk"
* "X:\TECH\environnement_de_developpement - Raccourci.lnk"
* "X:\TECH\Présentation_detail_circuit - Raccourci.lnk"
  
### Windows

* Files in each dig IP/Soc folder
  * Excel/drawio Drawings
  * Docx Spec: design, archi
  * Excel regbank ou memmap
  * Excel Verification matrix (testsuite... ?)
* Soc memmap xlsx:  
    PROJETS/\<projname>/Digital_design/top/regbank/\<projname>_mem_map_def.xlsx
* IPs regbank xlsx  
    PROJETS/\<projname>/Digital_design/blocs/\<IPname>/\<Ipname>_regbank_C0.xlsx
* Folder **vb_outputs** : where are generated files from VB scripts used to generate interm. Formats of memap and regbank xlsx files
  
### Linux

* Folder for IP/SoC design: pyxcaxxxx/Frontend/DIGIT/USERS/ddg_XXX_lib
* ddg_XXX_lib.cshrc script :
  * ***FIXME***: when is it called ? by which script ?
* Folder hierarchy: ~idem to windows structure
* Files in each dig IP/Soc folder:
  * All :
    * **Global** folder:
      * *.lst file to list source files used for different targets : RTL, SYNTH, POST, .... For sim/synth/...
    * **DOCUMENTS** folder:
      * Memmap, Reglist, tb_regbank txt files used by generators (Soc decoder, IP canevas, testbench)
    * **In_files** folder:
      * Seq and test files generated in Windows env.
    * **nc_sim** folder:
      * Simulation must be launched from this folder
  * SoC :
    * **Config_proj** folder
      * contains list of git repo used by project with sparse checkout approach
  * Testbench struct
    * ***TODO*** to be filled. Different for IP, Top and CPU_system_lib. It will be a specific documentation paragraph below
  * Current Shared git libs
    * Ddg_global_lib : RTL blocks that are IPs
    * Ddg_ip_lib : RTL IPs
    * Ddg_reuse_lib : common RTL blocks not IPs reused and conventional in RTL design (clock/mux/arith/fifo/...)
    * Ddg_soft_lib : SW libs for firmware
    * Ddg_sv_lib : testbench components and templates
    * Ddg_tools_lib :
      * $TOOLS_LIB
      * Scripts, generators, fourre tout de moulinettes en differents langages historiques
    * Ddg_utils_lib : some RTL packages with VHDL functions and else
  
### GIT management

* used scripts are in folder **$TOOLS_LIB/git_config***

## TODO - Dig Soc RTL design hierarchy at pyxalis

* ddg_dtop, ddg_top, aps_system_\<projname>/hw|sw, ...
* I:\ISO activities\DIGITAL\Methodologie\KVCA AEDVICES\environnement_de_developpement.docx

## Generation d'une IP
  
### Generate template architecture of the IP

Run script *$TOOLS_LIB/generator/scripts/structure/create_block.pl*

> create_block.pl -lib $PROJECT_LIB_NAME -name ddg_flofloip_lib
-Q- Is the block a Hard IP? ((true)|(false))
false
-Q- Gives between 3 and 9 letters for sub-blocks' prefix ([a-z0-9]{3,9})
flo
-Q- Does the block instantiate a comm subblock ? ((true)|(false))
true
-Q- Does the block instantiate a proc subblock ? ((true)|(false))
true
-Q- How many frame dynam clock for the register bank? ([0-9]+)
1
-Q- How many line dynam clock for the register bank? ([0-9]+)
1
-Q- Do we need to harden the APS bus ? (Hamming + sel signal triplication) ((true)|(false))
false
-Q- Does the block have ypix interface ? ((true)|(false))
true
-Q- Does the block have ytest interface ? ((true)|(false))
true
-Q- Number of signals to connect to YTEST ? (([1-9]|[12][0-9]|3[0-2]))
3

### Generate regbank views for HDL, C header IP,  memap IP

* Xls dans w10 de spec et script en VB (au secours !!!) pour generer une vue intermediaire au format txt
* Go into **SCRIPTS** folder of the IP: 
  * There is a README file to explain the process
* Run script *Get_regfiles* to import from windows to linux into **SCRIPTS/vb_outputs** and **DOCUMENTS** folders
***FIXME*** why both folders ? and not only one

> get_regfiles
is_top              = false
is_hip              = false
lib                 = ddg_riscvsys_lib
WIN_SERVER          = \\vm-main\iso
WIN_PROJ_NUMDIR     = "ISO activities\\DIGITAL\\PROJETS for presta\\RISCVSYS_for_presta\\\\Digital_design\\blocs"
WIN_PROJ_NUMDIR     = "ISO activities\\DIGITAL\\PROJETS for presta\\RISCVSYS_for_presta\\\\Digital_design\\blocs"
WIN_PROJ_APSDIR     = "ISO activities\\DIGITAL\\PROJETS for presta\\RISCVSYS_for_presta\\\\Digital_design\\blocs\\aps_system_riscvsys"
WIN_PYX_IP_DIR      = "ISO activities\DIGITAL\pyxalis_dig_IP\blocs"
WIN_PYX_HARD_IP_DIR = 
win_base_dir        = "ISO activities\\DIGITAL\\PROJETS for presta\\RISCVSYS_for_presta\\\\Digital_design\\blocs"
win_files_dir       = ddg_flofloip_lib\vb_outputs
 WARNING: You will be asked for your Windows
          password in order to retrieve the files.
 Retrieving regbank definition text file
-I- Proceed to copy register bank of block ddg_flofloip_lib, from windows
!!! TYPE PASSWORD HERE EVEN IF IS NOT WRITTEN TO BE ASKED FOR !!!
getting file \ISO activities\DIGITAL\PROJETS for presta\RISCVSYS_for_presta\Digital_design\blocs\ddg_flofloip_lib\vb_outputs\tb_regbank.txt of size 21097 as tb_regbank.txt (1287,7 KiloBytes/sec) (average 1287,7 KiloBytes/sec)
getting file \ISO activities\DIGITAL\PROJETS for presta\RISCVSYS_for_presta\Digital_design\blocs\ddg_flofloip_lib\vb_outputs\reglist_ddg_flofloip_lib.txt of size 20983 as reglist_ddg_flofloip_lib.txt (5122,7 KiloBytes/sec) (average 2054,7 KiloBytes/sec)
getting file \ISO activities\DIGITAL\PROJETS for presta\RISCVSYS_for_presta\Digital_design\blocs\ddg_flofloip_lib\vb_outputs\reglist_ddg_flofloip_lib.xml of size 194157 as reglist_ddg_flofloip_lib.xml (23700,5 KiloBytes/sec) (average 8239,3 KiloBytes/sec)
-I- Proceed to copy to DOCUMENTS
dos2unix: converting file reglist_ddg_flofloip_lib.xml to Unix format ...
dos2unix: converting file reglist_ddg_flofloip_lib.txt to Unix format ...
dos2unix: converting file tb_regbank.txt to Unix format ...

* Run *regbank_gen RTL* script to automatically generate regbank RTL files in ../RTL, and update RTL files dependant of registers
* Run *regbank_gen APS3 \<aps_system_name> \<eclipse project>* to automatically generate regbank C structure in .h files for CPU software
* Run *regbank_gen APS3_MEM_MAP \<aps_system_name> \<eclipse project>* to automatically generate memory mapping in mem_map.h files for CPU software. **To be done at chip top level only**.

## TODO - generation du SoC bus decoder

## TODO - available commands in $TOOLS_LIB

* most of scripts are located in *$TOOLS_LIB/generator/scripts/structure* folder
* ***FIXME***:
  * detail here up to date and used scripts today in projects
  * is there a Top template generator ?
  
## Audit on current dig project management

Notes from Meeting with Pad on the 5/12/2023.

### Pb pas de centralisation des données actuellement dans les projets

* Empilement historique de plein de petites moulinettes faites en de multiples langages par des personnes différentes.
* Des trucs sous windows, des trucs sous linux

### Le pourquoi de vouloir améliorer le flot actuel

* 1ere idee « long terme » est d'avoir un environnement et une methodo qui permettent, à partir d'un point d'entree unique (spec excell SoC), de générer en trois coup de marteau une structure de SoC Dig fonctionnelle, toutes les IP generees, regbank generes, instantiées, et un env de tb où l'on peut faire tourner un 1er test « CSR » d'acces aux registres du memmap. Ceci centré autour de git.
  * *y a t il un generateur de template de Top ?*
* 2e idée de fond est d'etre git centric et d'unifier tools lib avec dans un 1er temps une surcouche python de commandes abstraites et simplifiées pour gérer :
  * Etre self contained à partir du repo git du projet SoC : scripts, tools, source, ebd_sw, tb, synth, techno pdk, ... 
    * On doit pouvoir faire un clone du projet top dans n'importe quel repertoire de travail 
    * On doit avoir un script visible dans le repertoire racine du projet du type *setup.sh* (en BASH svp !!!) pour definir le minimum syndical de variables d'environnement (TOOL_LIB et PROJNAME) afin de rendre dispo la commande python qui est le point d'entree de gestion des actions sur le projet. AVEC DE LA DOC pour chaque option
    * OU un makefile à la racine rassemble dans les targets l'ensemble des commandes dispo pour le projet. Et donc pas de variables d'environnement en dur. AVEC DE LA DOC pour chaque target
    * On ne doit plus avoir à se balader dans les repertoires pour lancer des commandes. 
  * Gérer les dependances d'IP par tags version SemVer au niveau SoC
  * Creation, update, ... du SoC ou des IP en terme de version/tag sur git
  * Generation automatique de toute la Db intermediaire (filelist, IO ports list d'IP, instances list SoC, scripts simu,synth,pnr, tb testcase input files ...)
  * Generation du RTL/C/Tb/regbank des IPs auto à partir des spec excell IP et SoC
  * Generation du RTL/C/Tb/bus du SoC auto à partir des spec excell IP et SoC
* 3e idée : garder pour l'instant ce qui marche même si c'est pas parfait. Créer une surcouche pour cacher ca en 1er. Ensuite il sera possible de faire évoluer en off le backend de manière transparente pour être plus unifié, durable, modulaire, évolutif, structuré, ...

