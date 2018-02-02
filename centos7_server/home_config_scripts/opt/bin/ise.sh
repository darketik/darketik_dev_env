#!/bin/bash

export LANG=en_US.utf8
export DISPLAY=`echo $DISPLAY | sed 's/\.[0-9]*$//'`

source /home/florent/opt/Xilinx/14.7/ISE_DS/settings64.sh

ise &

