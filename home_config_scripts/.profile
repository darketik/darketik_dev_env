# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/opt/bin" ] ; then
    PATH="$HOME/opt/bin:$PATH"
    PATH="$HOME/opt/bin/gcc-arm-none-eabi/bin:$PATH"
    PATH="$HOME/opt/bin/eclipse:$PATH"
 #   PATH="$HOME/opt/bin/thunderbird:$PATH"
 #   PATH="$HOME/opt/bin/scilab-5.5.0/bin:$PATH"
 #   PATH="$HOME/opt/bin/arduino-0100-Z:$PATH" # zpuino official ide
 #   PATH="$HOME/opt/bin/papilio-zap-ide:$PATH" # zpuino for papilio ide
 #   PATH="$HOME/opt/bin/zpu-toolchain-linux-1.0/bin:$PATH"
fi


if [ -d "/opt/Xilinx/DocNav" ] ; then
    PATH="/opt/Xilinx/DocNav:$PATH"
fi


ssh-add $HOME/.ssh/id_rsa






