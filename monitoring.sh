#!bin/bash

#Arch
arch=$(uname -a)

#CPU PHISICAL
cpuph=$(lscpu | grep Socket | awk '{print $2}')

#CPU VIRTUAL
cpuvi=$(nproc)

#RAM
ram_total=$(free -m | grep Mem | awk '{print $2}' )
ram_used=$(free -m | grep Mem | awk '{print $3}')
ram_percen=$(free -m | grep Mem | awk '{print $3/$2 * 100}')


#DISK

disk_total=