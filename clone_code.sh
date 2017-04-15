#!/bin/bash

cd $HOME
mkdir -p opt
mkdir -p opt/bin

## Install main dev env repo
#+ cd $HOME/opt
#+ git clone https://github.com/darketik/darketik_dev_env.git dev_env_scripts
#+ pushd dev_env_scripts
#+ chmod +x *.sh
#+ popd

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
pushd $HOME/opt/dev_env_scripts/home_config_scripts
install -v -D .asoundrc $HOME
install -v -D .bash_aliases $HOME
install -v -D .bachrc $HOME
install -v -D .emacs $HOME
install -v -D .gitconfig $HOME
install -v -D .gitignore $HOME
install -v -D .mailrc $HOME
install -v -D mentor.bashrc $HOME
install -v -D .profile $HOME
install -v -D smartdv.bashrc $HOME
install -v -D .vim $HOME
install -v -D .vimrc $HOME
install -v -D xilinx.bashrc $HOME
popd

## $HOME/opt scripts
pushd $HOME/opt/dev_env_scripts/home_config_scripts
install -v -D opt/bin/* $HOME/opt/bin
popd

## /etc/rc.local
pushd $HOME/opt/dev_env_scripts/system_config/etc
sudo install -v -D rc.local /etc
popd

## $HOME/work/lib
mkdir -p $HOME/work/lib/externals
# externals
# 	mbed - https://github.com/mbedmicro/mbed.git
git clone https://github.com/mbedmicro/mbed.git $HOME/work/lib/externals/mbed
# 	newlib - git://sourceware.org/git/newlib-cygwin.git
git clone git://sourceware.org/git/newlib-cygwin.git $HOME/work/lib/externals/newlib
#		STM32CubeF4 v1.15.0
# TODO get from sftp darketik NAS
# libstm32f4 - https://github.com/darketik/libstm32f4.git 
git clone https://github.com/darketik/libstm32f4.git $HOME/work/lib/libstm32f4
# kicad 
# TODO don't know yet how to manage it

## $HOME/work/projects
mkdir -p $HOME/work/projects/externals
pushd $HOME/work/projects/externals
# externals
#		chibios - https://github.com/ChibiOS/ChibiOS.git
git clone https://github.com/ChibiOS/ChibiOS.git chibios
#		dfu-util - git://gitorious.org/dfu-util/dfu-util.git
git clone https://git.code.sf.net/p/dfu-util/dfu-util dfu-util
# FIXME
# 	stlink - https://github.com/texane/stlink.git
git clone https://github.com/texane/stlink.git stlink
#		stm32loader - https://github.com/jsnyder/stm32loader.git
git clone https://github.com/jsnyder/stm32loader.git stm32loader
#		papilio_projects
# TODO
#		mios32 - svn
# TODO
#		mutable_instruments
# TODO
#		owl
# TODO
# 	sonic_potions xlr - https://github.com/SonicPotions/LXR.git
git clone https://github.com/SonicPotions/LXR.git LXR
#   axoloti 
git clone https://github.com/axoloti/axoloti.git axoloti
git clone https://github.com/axoloti/axoloti-contrib.git axoloti-contrib
git clone https://github.com/axoloti/axoloti-factory.git axoloti-factory
#   teensy audio library - 
git clone https://github.com/PaulStoffregen/Audio.git teensy_audio_library
# TODO

#   thing workshop stm32f4 synth
git clone https://github.com/thi-ng/ws-ldn-3.git thing_diy_workshop_synth
#   preenFM2
# TODO

popd

pushd $HOME/work/projects
# mfos dual power supply 12v
# TODO
# lua
# TODO
# papilio_pro_fpga
# TODO
# rpi_2
# TODO
# soundbite
# TODO
# spice_sim
# TODO
# stm32f4discovery - 
git clone https://github.com/darketik/stm32f4discovery.git stm32f4discovery
pushd stm32f4discovery
git submodule init
git submodule update
popd
# sw4stm32
# TODO

popd

pushd $HOME/work
## gwt GAP 
git clone git@iis-git.ee.ethz.ch:greenwaves-technologies/GAP.git gap8
pushd gap8
make update-all
popd

## fpga training: zynqbook, z-turn myir board, bookshelf yao training
# TODO

popd


## gnupg keys
# TODO
## ssh keys
# TODO
## openvpn config
# TODO

## thunderbird mail account
# TODO
