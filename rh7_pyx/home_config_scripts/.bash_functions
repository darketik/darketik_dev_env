#! /bin/bash
# vi: syntax=bash

# find the largest files in a directory:
function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}

# grep (search) through your history for previous run commands
function hg() {
    history | grep "$1";
}

# display useful system information
function print_sysinfo() {
    # clear

    printf "\n"
    printf "   %s\n" "IP ADDR: $(curl ifconfig.me)"
    printf "   %s\n" "SHELL: $(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)"
    printf "   %s\n" "USER: $(echo $USER)"
    printf "   %s\n" "DATE: $(date)"
    printf "   %s\n" "UPTIME: $(uptime -p)"
    printf "   %s\n" "HOSTNAME: $(hostname -f)"
    printf "   %s\n" "CPU: $(lscpu | awk -F: '/Nom de modèle/{print $2}' | head -1 | awk '$1=$1')"
    printf "   %s\n" "KERNEL: $(uname -rms)"
    # printf "   %s\n" "PACKAGES: $(dpkg --get-selections | wc -l)"
    printf "   %s\n" "RESOLUTION: $(xrandr | awk '/\*/{printf $1" "}')"
    printf "   %s\n" "MEMORY: $(free -m -h | awk '/Mem/{print $3"/"$2}')"
    printf "\n"
}

# start a new project with Git
function git_init() {
    if [ -z "$1" ]; then
        printf "%s\n" "Please provide a directory name.";
    else
        mkdir "$1";
        builtin cd "$1";
        pwd;
        git init;
        touch readme.md .gitignore LICENSE;
        echo "# $(basename $PWD)" >> readme.md
    fi
}