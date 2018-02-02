#!/bin/bash
########### XILINX #############
#+ export LD_PRELOAD=/opt/Xilinx/usb-driver/libusb-driver.so
#+ export DISPLAY=:0

export LANG=en_US.utf8

export DISPLAY=`echo $DISPLAY | sed 's/\.[0-9]*$//'`

if [ -f /home/florent/opt/Xilinx/14.7/ISE_DS/settings64.sh ]; then
    . /home/florent/opt/Xilinx/14.7/ISE_DS/settings64.sh
fi

