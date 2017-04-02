#!/bin/bash

cd $HOME
mkdir opt

## Install main dev env repo
cd $HOME/opt
git clone https://github.com/darketik/darketik_dev_env.git dev_env_scripts
pushd dev_env_scripts
chmod +x *.sh
popd

## $HOME config scripts
# .bachrc
# *.bachrc : mentor, xilinx, smartdv, ...
# .bash_aliases
# .profile
# .gitconfig
# .gitignore
# .vimrc
# .emacs
# .vim folder
pushd $HOME/opt/home_config_scripts
install -v -D .bachrc $HOME
install -v -D .bash_aliases $HOME
install -v -D .profile $HOME
install -v -D .gitconfig $HOME
install -v -D .gitignore $HOME
install -v -D .vimrc $HOME
install -v -D .emacs $HOME
install -v -D .vim $HOME
popd

## $HOME/opt scripts
pushd $HOME/opt/home_config_scripts
install -v -D opt/bin $HOME/opt
popd

## $HOME/work/lib
# externals
# 	mbed - https://github.com/mbedmicro/mbed.git
# 	newlib - git://sourceware.org/git/newlib-cygwin.git
# libstm32f4 - https://github.com/darketik/libstm32f4.git 
# kicad 

## $HOME/work/projects
# template project structure
# mfos dual power supply 12v
# externals
#		chibios - https://github.com/ChibiOS/ChibiOS.git
#		dfu-util - git://gitorious.org/dfu-util/dfu-util.git
#		papilio_projects
#		mios32 - svn
#		mutable_instruments
#		owl
# 	sonic_potions xlr - https://github.com/SonicPotions/LXR.git
# 	stlink - https://github.com/texane/stlink.git
#		stm32loader - https://github.com/jsnyder/stm32loader.git
# lua
# papilio_pro_fpga
# rpi_2
# soundbite
# spice_sim
# stm32f4discovery - https://github.com/darketik/stm32f4discovery.git
# sw4stm32

## gnupg keys
## ssh keys
## openvpn config

## thunderbird mail account
