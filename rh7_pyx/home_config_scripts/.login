# ~/.login standard copie lors de la creation d'un compte.
# NL - 3/2/11 - delete users1 path for PYXALIS environment
#-Ne Pas Modifier les Lignes Suivantes.
#

if (! $?CMD) setenv CMD /cmd
if (! $?AFF_X) set AFF_X
#
tty -s
if ($status == 0 || $AFF_X == OK ) then
	if (! $?DISPLAY) setenv DISPLAY `hostname`:0
	switch (`uname -s`)
		case SunOS:
		case HP-UX:
			if (-e $HOME/.mylogin) source $HOME/.mylogin
			source $CMD/tcs.login
			breaksw
		case Linux:
			source $CMD/linux.login
			if (-e $HOME/.mylogin) source $HOME/.mylogin
			breaksw
		default:
	endsw
endif
#
#-Rien ne sera execute au dela de cette ligne.
#
# Fin
