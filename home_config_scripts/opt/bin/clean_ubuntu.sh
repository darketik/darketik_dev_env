#!/bin/bash

sudo rm /var/cache/apt/archives/*.deb

sudo apt-get autoclean

sudo apt-get autoremove

rm -r -f ~/.Trash/*

uname -r
dpkg -l | grep -Ei "linux-headers|linux-image"

#sudo apt-get remove linux-headers-3.5.0-17 linux-headers-3.5.0-17-generic linux-image-3.5.0-17-generic linux-image-extra-3.5.0-17-generic --purge
