#! /bin/csh
# vi: syntax=tcsh

limit coredumpsize 0

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
set     end="%{\033[0m%}" 

# FR> set prompt; with current git branch if available.
alias __git_current_branch 'git rev-parse --abbrev-ref HEAD >& /dev/null && echo "(`git rev-parse --abbrev-ref HEAD`)"'
alias precmd 'set prompt="${red}%n@${magenta}%m:${yellow}%c ${cyan}`__git_current_branch`${end}\% "'

# FR> my CSh env variable
if (-e $HOME/.cshrc_tools) source $HOME/.cshrc_tools

# Aliases
if (-e $HOME/.cshrc_aliases) source $HOME/.cshrc_aliases

## Set umask for new folder/files permissions defaut setting
umask 022

unsetenv CMD

## FR> jump into bash shell
scl enable devtoolset-12 bash