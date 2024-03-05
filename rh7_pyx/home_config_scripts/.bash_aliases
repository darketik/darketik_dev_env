#! /bin/bash
# vi: syntax=bash

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias psflo='ps faux | grep florent'
alias man='/usr/bin/man'

alias k1='kill %1'
alias k9='kill -9'

# Move to the parent folder.
alias ..='cd ..;pwd'

# Move up two parent folders.
alias ...='cd ../..;pwd'

# Move up three parent folders.
alias ....='cd ../../..;pwd'

# Press c to clear the terminal screen.
alias c='clear'

# Press h to view the bash history.
alias h='history'

# Display the directory structure better.
alias tree='tree --dirsfirst -F'

# Make a directory and all parent directories with verbosity.
alias mkdir='mkdir -p -v'

# View the calender by typing the first three letters of the month.

alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'


## PYX STRANGER THINGS

# export CMD=/cmd
alias whichproj='head -3 $CMD/projets/projdef; grep -i "\!*" $CMD/projets/projdef; tail -1 $CMD/projets/projdef;echo $comment;echo $CMD/projets/projdef;echo $comment'
alias pyxca52="source $HOME/pyx_utils/set_pyx_proj.sh pyxca52"

