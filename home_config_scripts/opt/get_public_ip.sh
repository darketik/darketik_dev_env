#!/bin/bash

ip=$(wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f2 | cut -d' ' -f2 | cut -d\< -f1)

while read line
do oldip=$line
done < "/home/florent/opt/bin/.mypublicip"

echo $ip > /home/florent/opt/bin/.mypublicip

if [[ "$ip" != "$oldip" ]]; then
  echo $ip | mail -s "gwt-Precision-Tower-3620 public IP changed" florent.rotenberg@greenwaves-technologies.com
  echo $ip | mail -s "gwt-Precision-Tower-3620 public IP changed" yao.zhang@greenwaves-technologies.com
  echo $ip | mail -s "gwt-Precision-Tower-3620 public IP changed" fabien.vauvilliers@greenwaves-technologies.com
fi


