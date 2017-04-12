#!/bin/bash

ip=$(ip -o addr show | grep  br0 | grep 'inet '| awk -F'inet ' '{print $2}' | cut -d\/ -f1)

while read line
do oldip=$line
done < "/home/florent/opt/bin/.myprivateip"

echo $ip > /home/florent/opt/bin/.myprivateip

if [[ "$ip" != "$oldip" ]]; then
  echo $ip | mail -s "gwt-Precision-Tower-3620 private IP changed" florent.rotenberg@greenwaves-technologies.com
  echo $ip | mail -s "gwt-Precision-Tower-3620 private IP changed" yao.zhang@greenwaves-technologies.com
  echo $ip | mail -s "gwt-Precision-Tower-3620 private IP changed" fabien.vauvilliers@greenwaves-technologies.com
fi


