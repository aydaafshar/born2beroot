#!/bin/bash

#Arch
arch=$(uname -a)

#CPU PHISICAL
cpuph=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)

#CPU VIRTUAL
cpuvi=$(nproc)

#RAM
ram_total=$(free -m | grep Mem | awk '{print $2}' )
ram_used=$(free -m | grep Mem | awk '{print $3}' )
ram_percen=$(free -m | grep Mem | awk '{printf("%.2f"),$3/$2 * 100}' )


#DISK

disk_total=$(df -h --block-size=G --total | tail -n 1 | awk '{print $2}' | cut -d G -f1)
disk_used=$(df -h --block-size=G --total | tail -n 1 | awk '{print $3}' | cut -d G -f1)
disk_percent=$(df -h --block-size=G --total | tail -n 1 | awk '{print $5}' | cut -d % -f1)

#CPU LOAD
cpu_l=$(vmstat 1 2 | tail -n 1 | awk '{print $15}' )
cpu_u=$(expr 100 - $cpu_l)
cpu_f=$(printf "%.1f" $cpu_u)

#LAST BOOT
last_b=$(who -b | awk '{print $3 " " $4}' )

#LVMAC

lvm_u=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

#the number of active connections

num_ac_con=$(ss -ta | grep "STAB" | wc -l)

#user-log
user_log=$(users | wc -w)


#NETWORK
ipv4=$(hostname -I | awk '{print $1}')
mac=$(ip link | grep "link/ether" | awk '{print $2}')

#sudo
sudo_command=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)


wall "#Architecture:$arch
#CPU physical:$cpuph
#vCPU:$cpuvi
#Memory Usage: $ram_used/${ram_total}MB ($ram_percen%)
#Disk Usage: $disk_used/$disk_total ($disk_percent%)
#CPU load:$cpu_f%
#Last boot:$last_b
#LVM use:$lvm_u
#Connection TCP:$num_ac_con ESTABLISHED
#User log:$user_log
#NETWORK: IP $ipv4 ($mac)
#sudo:$sudo_command cmd"