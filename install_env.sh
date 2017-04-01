#!/bin/bash

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

cd $HOME/opt/src
wget https://github.com/atom/atom/releases/download/v1.15.0/atom-amd64.deb 
sudo dpkg -i atom-amd64.deb

##########################
## Python
##########################
sudo easy_install3 artifactory jenkinsapi sqlalchemy prettytable
sudo apt-get install -y python3-pip
sudo pip3 install pyelftools

##########################
## java8
##########################
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
java –version
sudo apt-get install oracle-java8-set-default


##########################
## flexlm license server deamon startup
##Lmgrd license service 
##	Added launch cmd into /etc/rc.local file
##########################
# TODO



##########################
## Install vpn server openvpn
## http://www.evilbox.ro/linux/install-bridged-openvpn-on-ubuntu-14-04-x64-server-and-configure-windows-8-1-x64-client/
##########################
# TODO

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
## STM32 F4 tools
##########################
## sw4stm32 workbench
# TODO
## stm32CubeMX
# TODO


##########################
## Xilinx Vivado 
##########################
# TODO



##########################
## IC EDA tools
##########################
# Mentor Questasim
# TODO


# VIP SMartDV
# TODO



## Openocd
# TODO

## Scilab
# TODO

## Octave
# TODO

## Gnu-gcc-arm
# TODO

## System Workbench for STM32
# TODO

## Stm32Cube MX
# TODO

## papilio loader, arduino ide
# TODO

## arduino
# TODO

## teensy
# TODO











##########################
## from olivier gillet
##########################
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Install basic development tools
sudo dpkg --add-architecture i386
sudo apt-get update -qq
sudo apt-get install -y build-essential autotools-dev autoconf pkg-config libusb-1.0-0 libusb-1.0-0-dev libftdi1 libftdi-dev git libc6:i386 libncurses5:i386 libstdc++6:i386 cowsay figlet language-pack-en
sudo locale-gen UTF-8

# Install python
sudo apt-get install -y python2.7 python-numpy python-scipy python-matplotlib

# Install development tools for avr
sudo apt-get install -y gcc-avr binutils-avr avr-libc avrdude

# Install openocd
cd /home/vagrant
wget -nv https://downloads.sourceforge.net/project/openocd/openocd/0.9.0/openocd-0.9.0.tar.gz
tar xfz openocd-0.9.0.tar.gz
cd openocd-0.9.0
./configure --enable-ftdi --enable-stlink
make
sudo make install
cd /home/vagrant
rm -rf openocd-0.9.0
rm *.tar.gz

# Install stlink
cd /home/vagrant
wget -nv https://github.com/texane/stlink/archive/1.1.0.tar.gz
tar xfz 1.1.0.tar.gz
cd stlink-1.1.0
./autogen.sh
./configure
make
sudo make install
sudo cp 49-stlink*.rules /etc/udev/rules.d/
cd /home/vagrant
rm -rf stlink-1.1.0
rm *.tar.gz

# Allow non-root users to access USB devices such as Atmel AVR and Olimex
# programmers, FTDI dongles...
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2104", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", KERNEL=="ttyUSB*", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", GROUP="users", MODE="0666", SYMLINK+="ftdi-usbserial"' >> /etc/udev/rules.d/60-programmers.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Install toolchain for STM32F
cd /home/florent
wget -nv https://launchpad.net/gcc-arm-embedded/4.8/4.8-2013-q4-major/+download/gcc-arm-none-eabi-4_8-2013q4-20131204-linux.tar.bz2
tar xjf gcc-arm-none-eabi-4_8-2013q4-20131204-linux.tar.bz2
sudo mv gcc-arm-none-eabi-4_8-2013q4 /usr/local/arm-4.8.3/
rm *.tar.bz2
# (We're progressively checking that all STM32F1 projects can also be built with
# this gcc version instead of 4.5.2).
ln -s /usr/local/arm-4.8.3 /usr/local/arm

