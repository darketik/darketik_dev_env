#!/bin/bash

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

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
## spotify family
##########################
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install -y spotify-client

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
sudo apt-add-repository ppa:libreoffice/ppa
sudo apt-get update
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
sudo apt-get install -y oracle-java8-set-default

##########################
## Install vpn server openvpn
## http://www.evilbox.ro/linux/install-bridged-openvpn-on-ubuntu-14-04-x64-server-and-configure-windows-8-1-x64-client/
##########################
#+ sudo apt-get install -y bridge-utils openvpn libssl-dev openssl
#+ # edit /etc/network/interfaces
#+ # TODO
#+ # edit /etc/sysctl.conf
#+ # TODO
#+ sudo apt-get install -y easy-rsa
#+ sudo su
#+ make-cadir /etc/openvpn/easy-rsa
#+ # edit /etc/openvpn/easy-rsa/vars
#+ # TODO

#+ # gen server key
#+ cd /etc/openvpn/easy-rsa/
#+ source vars
#+ ./clean-all
#+ ./build-dh
#+ ./pkitool --initca
#+ ./pkitool --server server
#+ cd keys
#+ openvpn --genkey --secret ta.key
#+ cp server.crt server.key ca.crt dh2048.pem ta.key /etc/openvpn/

#+ # gen client key
#+ cd /etc/openvpn/easy-rsa/
#+ source vars
#+ ./pkitool client-name

# TODO finish openvpn flow

##########################
## Audio tools
##########################
## alsa
sudo apt-get install -y alsa-base alsa-utils gstreamer1.0-alsa linux-sound-base alsa-firmware-loaders alsa-oss alsa-tools alsa-tools-gui alsamixergui alsaplayer-jack oss-compat
sudo apt-get install -y paman pavucontrol pavumeter

## jackd audio connection kit
# https://github.com/jackaudio
sudo apt-get install -y libjack-jackd2-0 libjack-jackd2-dev pulseaudio-module-jack jackd2 jack-tools qjackctl

## PureData - pd-extended
# https://github.com/agraef/purr-data
cd $HOME/opt/src
sudo apt-get install libglew-dev libmagick++-dev libftgl2 libgmerlin0 libgmerlin-avdec1 libavifile-0.7c2 libmpeg3-dev libmpeg3-2 libquicktime2 libdc1394-22 libfftw3-3 libmp3lame0
# if you have troubles with previous cmd, exec: sudo apt-get -f install -y
wget https://github.com/agraef/purr-data/releases/download/2.1.2/pd-l2ork-2.1.2-ubuntu_14.04-x86_64.deb
sudo dpkg -i pd-l2ork-2.1.2-ubuntu_14.04-x86_64.deb

## superCollider 
# https://supercollider.github.io/
sudo add-apt-repository ppa:supercollider/ppa
sudo apt-get update
sudo apt-get install -y supercollider

## Chuck
# http://chuck.cs.princeton.edu/
sudo apt-get install -y libsndfile1-dev
cd $HOME/opt/src
wget http://chuck.cs.princeton.edu/release/files/chuck-1.3.5.2.tgz
tar -xzvf chuck-1.3.5.2.tgz
cd chuck-1.3.5.2/src
make linux-jack
sudo make install
cd $HOME/opt/src
rm -rf chuck-1.3.5.2

# miniAudicle - gui for chuck
# needs qt 4.8+, alsa or jack
sudo apt-get install -y make gcc g++ bison flex libasound2-dev libsndfile1-dev libqt4-dev libqscintilla2-dev  libjack-jackd2-dev
cd $HOME/opt/src
wget http://audicle.cs.princeton.edu/mini/release/files/miniAudicle-1.3.5.2.tgz
tar -xzvf miniAudicle-1.3.5.2.tgz
cd miniAudicle-1.3.5.2/src
make linux-jack
sudo make install
cd $HOME/opt/src
rm -rf miniAudicle-1.3.5.2

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

# axoloti gui patcher
sudo apt-get install -y lib32z1 lib32ncurses5 lib32z1-dev
pushd $HOME/opt/src
wget https://github.com/axoloti/axoloti/releases/download/1.0.12-1/axo_runtime_linux_1.0.12-1.tgz
mv axo_runtime_linux_1.0.12-1.tgz $(HOME)
pushd $HOME
tar -xzvf axo_runtime_linux_1.0.12-1.tgz
popd
wget https://github.com/axoloti/axoloti/releases/download/1.0.12-1/axoloti-linux-1.0.12-1.deb
sudo dpkg -i axoloti-linux-1.0.12-1.deb
sudo $HOME/axoloti_runtime/platform_linux/add_udev_rules.sh


##########################
## Misc
##########################
sudo apt-get install -y vim vim-gnome vim-scripts exuberant-ctags gnupg2 openssh-server
sudo apt-get install -y git g++ python3-setuptools swig3.0 python3-dev libjpeg-dev libz-dev cmake lib32z1 lib32ncurses5 ant openjdk-7-jdk
sudo apt-get install -y csh
sudo apt-get install -y python-yaml
sudo apt-get install -y tcsh
sudo apt-get install -y libswitch-perl
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y python-software-properties
sudo apt-get install -y mailutils
sudo apt-get install -y software-properties-common
sudo apt-get install -y samba 
sudo apt-get install -y gitk
sudo apt-get install -y system-config-samba
sudo apt-get install -y cutecom
sudo apt-get install -y nmap
sudo apt-get install -y subversion

## basic dev tools
sudo dpkg --add-architecture i386
sudo apt-get update -qq
sudo apt-get install -y build-essential autotools-dev autoconf pkg-config libusb-1.0-0 libusb-1.0-0-dev libftdi1 libftdi-dev git libc6:i386 libncurses5:i386 libstdc++6:i386 cowsay figlet language-pack-en libgtk-3-dev
sudo locale-gen UTF-8

## lua
sudo apt-get install -y lua5.1
sudo apt-get install -y liblua5.1-0-dev

## atom editor
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
sudo apt-get install -y jenkins
sudo apt-get install -y gitlab-ci-multi-runner

## Scilab
# http://www.scilab.org/
cd $HOME/opt/src
wget http://www.scilab.org/download/6.0.0/scilab-6.0.0.bin.linux-x86_64.tar.gz
tar -xzvf scilab-6.0.0.bin.linux-x86_64.tar.gz
mv scilab-6.0.0 $HOME/opt
# TODO add scilab to $PATH env var

## Octave
# https://www.gnu.org/software/octave/
sudo apt-get install -y gcc g++ gfortran make libblas-dev liblapack-dev libpcre3-dev libarpack2-dev libcurl4-gnutls-dev epstool libfftw3-dev transfig libfltk1.3-dev libfontconfig1-dev libfreetype6-dev libgl2ps-dev libglpk-dev libreadline-dev gnuplot-x11 libgraphicsmagick++1-dev libhdf5-serial-dev openjdk-8-jdk libsndfile1-dev llvm-dev lpr texinfo libgl1-mesa-dev libosmesa6-dev pstoedit portaudio19-dev libqhull-dev libqrupdate-dev libqscintilla2-dev libqt4-dev libqtcore4 libqtwebkit4 libqt4-network libqtgui4 libqt4-opengl-dev libsuitesparse-dev texlive libxft-dev zlib1g-dev autoconf automake bison flex gperf gzip icoutils librsvg2-bin libtool perl rsync tar
#+ cd $HOME/opt/src
#+ wget https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.gz
#+ tar -xzvf octave-4.2.1.tar.gz
#+ cd octave-4.2.1
#+ ./configure && make 
#+ sudo make install
#+ rm -rf octave-4.2.1
# octave forge - https://octave.sourceforge.io/
# list of packages - https://octave.sourceforge.io/packages.php
# FIXME error: support for URL transfers was disabled when Octave was built
#+ pkg install -forge control
#+ pkg install -forge signal
#+ pkg install -forge general
#+ pkg install -forge communications
sudo apt-get install -y octave octave-communications octave-doc octave-general octave-htmldoc octave-image octave-info octave-io octave-missing-functions octave-signal octave-sockets octave-strings octave-tsa 

## matlab
# TODO buy home edition with DSP add-ons

##########################
## Electronic EDA tools
##########################
sudo add-apt-repository --yes ppa:js-reynaud/kicad-4
sudo apt-get update
sudo apt-get install -y kicad geda pcb gerbv easyspice ngspice ngspice-doc gspiceui gnucap oregano geda-utils geda-examples gwave kicad-locale-fr 

## LTSPICE with wine
sudo apt-get install -y wine
cd $HOME/opt/src
wget http://ltspice.linear-tech.com/software/LTspiceXVII.exe
chmod +x LTspiceXVII.exe
./LTspiceXVII.exe

## gtkwave
# http://gtkwave.sourceforge.net/
sudo apt-get install -y gtkwave

##########################
## AVR tools
##########################
#+ sudo apt-get install -y gcc-avr binutils-avr avr-libc avrdude

##########################
## STM32 F4 tools
##########################
## sw4stm32 workbench
# TODO

# Audio Weaver ST edition
# TODO get from sftp darketik NAS

## stm32CubeMX
# https://my.st.com/content/my_st_com/en/products/embedded-software/mcus-embedded-software/stm32-embedded-software/stm32cube-embedded-software/stm32cubef4.license%3d1491167185534.html
# TODO get from sftp darketik NAS
#+ sudo ./SetupSTM32CubeMX-4.20.0.linux
# /usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/STM32CubeMX

## Gnu-gcc-arm
cd $HOME/opt/src
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
sudo mv gcc-arm-none-eabi-5_4-2016q3 $HOME/opt
cd $HOME/opt
ln -s gcc-arm-none-eabi-5_4-2016q3 gcc-arm-none-eabi

## arduino
# https://www.arduino.cc/en/Main/Software
cd $HOME/opt/src
wget https://www.arduino.cc/download_handler.php?f=/arduino-1.8.2-linux64.tar.xz
tar -xf arduino-1.8.2-linux64.tar.xz
cd arduino-1.8.2
./install.sh
cd $HOME/opt/src
mv arduino-1.8.2 ..
#TODO add arduino to $PATH

## teensy
# https://www.pjrc.com/
cd $HOME/opt/src
wget https://www.pjrc.com/teensy/49-teensy.rules
sudo cp 49-teensy.rules /etc/udev/rules.d/
cd $HOME/opt/src
wget https://www.pjrc.com/teensy/td_136/TeensyduinoInstall.linux64
chmod +x TeensyduinoInstall.linux64
sudo ./TeensyduinoInstall.linux64

## papilio loader
# TODO

## papilio zap ide
# TODO

## openocd
cd $HOME/opt/src
wget https://downloads.sourceforge.net/project/openocd/openocd/0.10.0/openocd-0.10.0.tar.bz2
tar -xjf openocd-0.10.0.tar.gz
pushd openocd-0.10.0
./configure --enable-ftdi --enable-stlink
make
sudo make install
popd
rm -rf openocd-0.10.0

## stlink
cd $HOME/opt/src
wget https://github.com/texane/stlink/archive/1.3.1.tar.gz
tar -xzf 1.3.1.tar.gz
pushd stlink-1.3.1
sudo apt-get install -y cmake libusb-1.0 libusb-1.0.0-dev libgtk-3-dev
make release
cd build/Release; sudo make install
popd
rm -rf stlink-1.3.1

# Install stlink
# Allow non-root users to access USB devices such as Atmel AVR and Olimex
# programmers, FTDI dongles...
sudo su
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="0003", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002a", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="15ba", ATTRS{idProduct}=="002b", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2104", GROUP="users", MODE="0666"' >> /etc/udev/rules.d/60-programmers.rules
echo 'SUBSYSTEMS=="usb", KERNEL=="ttyUSB*", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", GROUP="users", MODE="0666", SYMLINK+="ftdi-usbserial"' >> /etc/udev/rules.d/60-programmers.rules
exit
sudo udevadm control --reload-rules
sudo udevadm trigger


##########################
## Xilinx Vivado 
##########################
# to fix an issue in DocNav
sudo apt-get install libglib2.0-0:i386
# TODO get from sftp darketik NAS

##########################
## flexlm license server deamon startup
##Lmgrd license service 
##	Added launch cmd into /etc/rc.local file
##########################
# TODO get from sftp darketik NAS

##########################
## IC EDA tools
##########################
# Mentor Questasim
# TODO get from sftp darketik NAS

# VIP SMartDV
# TODO get from sftp darketik NAS

