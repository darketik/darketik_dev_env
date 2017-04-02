#!/bin/bash

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

cd $HOME
mkdir -p opt/src

##########################
## Cloudstation
##########################
cd $HOME/opt/src
wget https://global.download.synology.com/download/Tools/CloudStationDrive/3.2-3501/Ubuntu/Installer/x86_64/synology-cloud-station-3501.x86_64.deb
sudo dpkg -i synology-cloud-station-3501.x86_64.deb

##########################
## thunderbird
##    module lightning, enigmail
##########################
# TODO

##########################
## Firefox
## Add-ons: 
## 	   Xmarks
## 		 Adblocks plus
## 		 Ghostery
## 		 Https everywhere
## 		 Messenge for google Hangout
##     enpass
##     Amazon whishlist
##########################
# TODO

##########################
## Dropbox deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu trusty main 
##########################
# TODO

##########################
## skype
##########################
# TODO

##########################
## Enpass
##########################
sudo su
echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list
wget -O - https://dl.sinew.in/keys/enpass-linux.key | apt-key add -
exit
sudo apt-get update -qq
sudo apt-get install -y enpass

##########################
## vncserver realvnc
##########################
# TODO
##sudo update-rc.d vncserver-x11-serviced defaults

##########################
## libreoffice repo
##########################
sudo apt-add-repository ppa:libreoffice/ppa:sudo apt-get update
sudo apt-get install -y libreoffice

## texlive, texmaker
# TODO

## gimp, inkscape (vector graphic)
# TODO

##########################
## java8
##########################
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
java –version
sudo apt-get install oracle-java8-set-default

##########################
## Install vpn server openvpn
## http://www.evilbox.ro/linux/install-bridged-openvpn-on-ubuntu-14-04-x64-server-and-configure-windows-8-1-x64-client/
##########################
# TODO

##########################
## Misc
##########################
sudo apt-get install -y vim vim-gnome
sudo apt-get install -y vim-scripts exuberant-ctags
sudo apt-get install -y gnupg2
sudo apt-get install -y openssh-server
sudo apt-get install -y git g++ python3-setuptools swig3.0 python3-dev libjpeg-dev libz-dev cmake lib32z1 lib32ncurses5 ant openjdk-7-jdk
sudo apt-get install -y csh
sudo apt-get install -y python-yaml
sudo apt-get install -y tcsh
sudo apt-get install -y libswitch-perl
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y python-software-properties
sudo apt-get install -y mailutils
sudo apt-get install -y software-properties-common
sudo apt-get install -y samba samba-doc
sudo apt-get install -y gitk
sudo apt-get install -y system-config-samba
sudo apt-get install -y cutecom
sudo apt-get install -y nmap
sudo apt-get install -y lua5.1
sudo apt-get install -y liblua5.1-0-dev

## basic dev tools
sudo dpkg --add-architecture i386
sudo apt-get update -qq
sudo apt-get install -y build-essential autotools-dev autoconf pkg-config libusb-1.0-0 libusb-1.0-0-dev libftdi1 libftdi-dev git libc6:i386 libncurses5:i386 libstdc++6:i386 cowsay figlet language-pack-en libgtk-3-dev
sudo locale-gen UTF-8


cd $HOME/opt/src
wget https://github.com/atom/atom/releases/download/v1.15.0/atom-amd64.deb 
sudo dpkg -i atom-amd64.deb

##########################
## Python
##########################
sudo apt-get install -y python2.7 python-numpy python-scipy python-matplotlib
sudo apt-get install -y python3-pip
sudo easy_install3 artifactory jenkinsapi sqlalchemy prettytable
sudo pip3 install pyelftools

##########################
## Jenkins tomcat7 method with war file
## https://doc.ubuntu-fr.org/jenkins
## https://docs.gitlab.com/ee/integration/jenkins.html
## https://docs.gitlab.com/ee/integration/jenkins.html#configure-the-jenkins-server
## https://github.com/jenkinsci/gitlab-plugin#jenkins-job-configuration
##########################
# TODO
sudo apt-get install -y jenkins
sudo apt-get install -y gitlab-ci-multi-runner

## PureData - pd-extended
# TODO

## superCollider 
# TODO

## Chuck
# TODO

## FaustLive
# TODO

## Processing 
# TODO

## Csound / Cecilia
# TODO

## openNI (gesture tracking) / openCV (computer vision)
# TODO

## Festival - speech synthesis
# TODO

## Gnaural - binaural audio generation
# TODO

## Scilab
# TODO

## Octave
# TODO

##########################
## Electronic EDA tools
##########################
sudo add-apt-repository --yes ppa:js-reynaud/kicad-4
sudo apt-get update
sudo apt-get install -y kicad
sudo apt-get install -y geda pcb gerbv
sudo apt-get install -y easyspice ngspice ngspice-doc
sudo apt-get install -y gspiceui gnucap 
sudo apt-get install -y oregano

## LTSPICE with wine
# TODO
sudo apt-get install -y wine
cd $HOME/opt/src
wget http://ltspice.linear-tech.com/software/LTspiceXVII.exe
chmod +x LTspiceXVII.exe
./LTspiceXVII.exe


## gtkwave
# TODO

##########################
## AVR tools
##########################
sudo apt-get install -y gcc-avr binutils-avr avr-libc avrdude

##########################
## STM32 F4 tools
##########################
## sw4stm32 workbench
# TODO

## stm32CubeMX
# TODO

## Openocd
# TODO

## Gnu-gcc-arm
cd $HOME/opt/src
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
sudo mv gcc-arm-none-eabi-5_4-2016q3 $HOME/opt
cd $HOME/opt
ln -s gcc-arm-none-eabi-5_4-2016q3 gcc-arm-none-eabi

## System Workbench for STM32
# TODO

## Stm32Cube MX
# TODO

## papilio loader
# TODO

## arduino
# TODO

## teensy
# TODO

## papilio zap ide
# TODO

## openocd
cd $HOME/opt/src
wget https://downloads.sourceforge.net/project/openocd/openocd/0.10.0/openocd-0.10.0.tar.bz2
tar xfz openocd-0.10.0.tar.gz
pushd openocd-0.10.0
./configure --enable-ftdi --enable-stlink
make
sudo make install
popd
rm -rf openocd-0.10.0

## stlink
cd $HOME/opt/src
wget https://github.com/texane/stlink/archive/1.3.1.tar.gz
tar xfz 1.3.1.tar.gz
pushd stlink-1.3.1
./autogen.sh
./configure
make
sudo make install
sudo cp 49-stlink*.rules /etc/udev/rules.d/
popd
rm -rf stlink-1.3.1

# Install stlink
# Allow non-root users to access USB devices such as Atmel AVR and Olimex
# programmers, FTDI dongles...
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2104", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", KERNEL=="ttyUSB*", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", GROUP="users", MODE="0666", SYMLINK+="ftdi-usbserial"' >> /etc/udev/rules.d/60-programmers.rules
sudo udevadm control --reload-rules
sudo udevadm trigger


##########################
## Xilinx Vivado 
##########################
# TODO

##########################
## flexlm license server deamon startup
##Lmgrd license service 
##	Added launch cmd into /etc/rc.local file
##########################
# TODO

##########################
## IC EDA tools
##########################
# Mentor Questasim
# TODO

# VIP SMartDV
# TODO

