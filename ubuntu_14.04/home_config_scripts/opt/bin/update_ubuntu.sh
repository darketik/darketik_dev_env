#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo rm /var/cache/apt/archives/*.deb
sudo apt-get autoclean -y
sudo apt-get autoremove -y

rm -r -f ~/.Trash/*

uname -r
dpkg -l | grep -Ei "linux-headers|linux-image"

#sudo apt-get remove linux-headers-3.5.0-17 linux-headers-3.5.0-17-generic linux-image-3.5.0-17-generic linux-image-extra-3.5.0-17-generic --purge
