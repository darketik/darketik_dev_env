#! /bin/bash
# vi: syntax=bash

alias vncserver_HD='vncserver-x11 -config /home/florent/.vnc/config.d/vncserver-x11 &'

alias vimgap='vim ips_list.yml fe/rtl/*/* fe/ips/*/* fe/tb/*.sv fe/tb/*/*.sv fe/tb/*/models/* fe/sim/Makefile fe/sim/vcompile/* fe/sim/vcompile/*/* fe/sim/tcl_files/*.tcl fe/sim/tcl_files/config/* \
	pulp_pipeline/runtime/archi/include/archi/*.h pulp_pipeline/runtime/archi/include/archi/GAP/*.h pulp_pipeline/runtime/hal/include/*.h pulp_pipeline/runtime/hal/include/hal/* \
	pulp_pipeline/runtime/pulp-rt/include/rt/*.h pulp_pipeline/runtime/rtl_libs/stdio_lib/include/stdio_lib.h pulp_pipeline/runtime/rtl_libs/bench_lib/include/bench.h \
	pulp_pipeline/runtime/rtl_libs/malloc_lib/include/malloc.h pulp_pipeline/runtime/rtl_libs/string_lib/include/string_lib.h \
	pulp_pipeline/tools/pulp_rules/rules/*.mk pulp_pipeline/tools/runner/runner/python/plp_rtl_runner.py'

alias vimrt='vim pulp_pipeline/runtime/archi/include/archi/*.h pulp_pipeline/runtime/archi/include/archi/GAP/*.h pulp_pipeline/runtime/hal/include/*.h pulp_pipeline/runtime/hal/include/hal/* \
	pulp_pipeline/runtime/pulp-rt/include/rt/*.h pulp_pipeline/runtime/rtl_libs/stdio_lib/include/stdio_lib.h pulp_pipeline/runtime/rtl_libs/bench_lib/include/bench.h \
	pulp_pipeline/runtime/rtl_libs/malloc_lib/include/malloc.h pulp_pipeline/runtime/rtl_libs/string_lib/include/string_lib.h'

alias vimrtl='vim ips_list.yml fe/rtl/*/* fe/ips/*/* fe/tb/*.sv fe/tb/*/*.sv fe/tb/*/models/* fe/sim/Makefile fe/sim/vcompile/* fe/sim/vcompile/*/* fe/sim/tcl_files/*.tcl \
  fe/sim/tcl_files/config/* pulp_pipeline/tools/pulp_rules/rules/*.mk pulp_pipeline/tools/runner/runner/python/plp_rtl_runner.py'

alias ll='ls -lh'
alias lla='ls -alh'
alias la='ls -a'
alias psflo='ps faux | grep florent'
alias man='/usr/bin/man'

alias svnst='svn st -qu'
alias svnstu='svn st -u'
alias svndiff='svn diff --diff-cmd /home/florent/bin/diffwrap.sh'
alias svnci='svn ci -m ""'
alias svnl='svn log | more'
alias svnlv='svn log -v | more'

alias k1='kill %1'
alias k9='kill -9'
alias ssh_gwt='ssh -XY florent@192.168.8.101'

alias gap_upd='git pull; ./update-ips.py ; ./update-sw ; source setup/sdk.sh ; ./update-tests'

# Function up - usage:
# up --> goes up one directory
# up <N> --> goes up N directories
# up <string> --> goes up to <string> parent directory if existing
up()
{
	dir=""
	if [ -z "$1" ]; then
		dir=..
	elif [[ $1 =~ ^[0-9]+$ ]]; then
		x=0
		while [ $x -lt ${1:-1} ]; do
			dir=${dir}../
			x=$(($x+1))
		done
	else
		dir=${PWD%/$1/*}/$1
	fi
	cd "$dir";
}
