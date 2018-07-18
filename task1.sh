#!/bin/bash


path="/home/vladyslav/Документы/output.txt"

#********Date info*************
date -R | sed 's/^/Date: /'# >> $path
echo "---- Hardware ----" >> $path


#********cpu info***************
cpu="$(grep -m 1 "model name" /proc/cpuinfo)"
echo "CPU: \"${cpu:13}\"" >> $path


#*********ram info**************
ram="$(grep -m 1 "MemTotal" /proc/meminfo)"
echo "RAM: ${ram:17}" >> $path


#*********motherboard***********
manufact="$(dmidecode -t 2 | grep "Manufacturer")"
prodname="$(dmidecode -t 2 | grep "Product Name")"
serialnumb="$(dmidecode -t 2 | grep "Serial Number")"
manufact=${manufact:15}
prodname=${prodname:15}
serialnumb=${serialnumb:15}

if [ -z "$manufact" ] ;then
	manufact="$Unknown"
fi

if [ -z "$prodname" ] ;then
	prodname="$Unknown"
fi

if [ -z "$serialnumb" ] ;then
	serialnumb="Unknown"
fi

echo "Motherboard: \"$manufact\", \"$prodname\"" >> $path
echo "System Serial Number: $serialnumb" >> $path


echo "---- System ----" >> $path

#*************distr & kernel********
distr="$(grep "DISTRIB_DESCRIPTION" /etc/*-release)"
distr=${distr:20}

if [ -z "$distr" ] ;then
distr="Unknow"
fi

uname -r -m | sed 's/^/Kernel version: '/ >> $path
uptime -p | sed 's/.*up/Uptime: /' >> $path
dumpe2fs $(mount | grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:' >> $path

