# ~/.cshrc standard copie lors de la creation d'un compte.
# NL - 8/2/11 - delete users1 path for PYXALIS environment
# NL - 2/5/11 - update for PYXALIS environment golden start files
# NL - 11/5/11 - update for PYXALIS environment golden start files
# NL - 15/5/15 - update for RHEL6, add test3 since groups are not listed in the same order with id -a
# EV - 05/04/18 - simplify the code, run pyx.initproj instead of tcs.initprojnew

#-Ne Pas Modifier les Lignes Suivantes.
#
if (! $?CMD) setenv CMD /cmd
limit coredumpsize 0
setenv LM_PROJECT 1230
setenv TYPE P
#
set test1 = `id -a | cut -d '(' -f 3| cut -d ')' -f 1`
set test2 = `id -a | cut -d '(' -f 4| cut -d ')' -f 1`
set test3 = `id -a | cut -d '(' -f 5| cut -d ')' -f 1`
#
switch (`uname -s`)
	case SunOS:
	case HP-UX:
		source $CMD/tcs.cshrc
		source $CMD/init_aliases
		source $CMD/projets_aliases
		QGRID_ENV
		if (-e $HOME/.mycshrc) source $HOME/.mycshrc
		if ( "$test1" != "$test2" ) then
			source $CMD/tcs.initprojnew
		endif
		breaksw
	case Linux:
                #echo "Debug pre source linux.cshrc"
		source $CMD/FICHIERS_DE_DEMARRAGE/pyxuser/linux.cshrc
                #echo "Debug pre source init_aliases"
		source $CMD/init_aliases
                #echo "Debug pre source projets_aliases"
		source $CMD/projets_aliases
#		QGRID_ENV
                #echo "Debug pre source /home/user/.cshrc"
		if (-e $HOME/.mycshrc) source $HOME/.mycshrc
		if ( "$test1" != "$test2" || "$test1" != "$test3" ) then
			source $CMD/pyx.initproj
		endif
		breaksw
	default:
endsw

######  Pour avoir l'historique csh avec date/heure:
set history= ( 5000 "%h  %Y/%W/%D  %T \t %R\n" )

#
#-Merci de ne rien executer au dela de cette ligne.
#
# Fin
