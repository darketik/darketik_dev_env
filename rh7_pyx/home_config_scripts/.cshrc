#! /bin/csh
# vi: syntax=tcsh

if (! $?CMD) setenv CMD /cmd

limit coredumpsize 0
# setenv LM_PROJECT 1230

# source $CMD/FICHIERS_DE_DEMARRAGE/pyxuser/linux.cshrc
# source $CMD/init_aliases
source $CMD/projets_aliases

# FR> Better git completion
source ~/.git-completion.tcsh
set autolist=ambiguous

# FR> Better CSH prompt
set     red="%{\033[1;31m%}"
set   green="%{\033[1;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}" # This is needed at the end... :(

# FR> set prompt; with current git branch if available.
alias __git_current_branch 'git rev-parse --abbrev-ref HEAD >& /dev/null && echo "(`git rev-parse --abbrev-ref HEAD`)"'
alias precmd 'set prompt="${red}%n@${magenta}%m:${yellow}%c ${cyan}`__git_current_branch`${end}\% "'

# FR> my CSh env variable
if (-e $HOME/.mycshrc_tools) source $HOME/.mycshrc_tools

# Aliases
if (-e $HOME/.mycshrc_aliases) source $HOME/.mycshrc_aliases

## Set umask for new folder/files permissions defaut setting
umask 022

## FR> jump into bash shell
scl enable devtoolset-12 bash