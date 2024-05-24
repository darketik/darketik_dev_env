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

# git facilitators
column_width=30
alias tableseparator='printf "|%s|\n" "$(printf -- "-%.0s" $(seq 1 $((2 * $column_width + 3))) )"'
alias gitstatusdir='for dir in */; do (cd "$dir" && git fetch && git status); done'
alias gitbranchdir='tableseparator && printf "| %-*s | %-*s |\n" "$column_width" "IP" "$column_width" "Branch" && tableseparator && for dir in */; do (cd "$dir" && printf "| %-*s | %-*s |\n" "$column_width" "$(basename "$(git rev-parse --show-toplevel)")" "$column_width" "$(git rev-parse --abbrev-ref HEAD)"); done && tableseparator'
alias gitupdatedir='for dir in */; do (cd "$dir" && git fetch && git pull); done'

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

## linux display resolution
alias set_display_qhd="xrandr -s 2560x1440_60.00"
alias set_display_fhd="xrandr -s 1920x1080_60.00"

## PYX STRANGER THINGS

# export CMD=/cmd
alias whichproj='head -3 $HOME/pyx_utils/projdef; grep -i "\!*" $HOME/pyx_utils/projdef; tail -1 $HOME/pyx_utils/projdef;echo $comment;echo $HOME/pyx_utils/projdef;echo $comment'
alias pyxca52="source $HOME/pyx_utils/set_pyx_proj.sh pyxca52"
alias pyxca46a0="source $HOME/pyx_utils/set_pyx_proj.sh pyxca46a0"
alias pkvl=pyxca52
alias ouranos=pyxca46a0

alias simv="simvision -64bit -waves compiled/rtl/waves.shm"
alias cdslic="lmutil lmstat -c $CDS_LIC_FILE -f"
alias kill_xm="ps | grep xmsim | awk '{print $1}' | xargs kill -9"

