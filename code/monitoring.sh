#!/bin/bash

# Déclarations des constantes
ARCH=$(uname -a)
PCPU=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(cat /proc/cpuinfo | grep processor | wc -l)

RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
RAM_PERC=$(free -k | awk '/Mem:/ {print $.2f}, $3 / $2 * 100')

DISK_USED=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 3)
DISK_TOTAL=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 2)
DISK_PERC=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 5)

CPU_LOAD=$(top -bn1 | grep "Cpu" | cut -d ' ' -f 3)
LAST_BOOT=$(who -b | tr -s ' ' | cut -d ' ' -f 4-5)
TCP=$(cat /proc/net/sockstat | grep TCP | cut -d ' ' -f 3)
USER_LOG=$(who | wc -l)

IP_ADDR=$(hostname -I)
MAC_ADDR=$(ip addr | grep link/ether | cut -d ' ' -f 3)

SUDO_LOG=$(grep -a COMMAND /var/log/sudo/sudo.log | wc -l)

LVM_STATUS=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo Nop; else echo Yep; fi)

# Commandes d'envoi sur tous les terminaux de tous les utilisateurs
wall "
------------------------------------------------
Architecture    : $ARCH
Physical CPUs   : $PCPU
Virtual CPUs    : $VCPU
Memory Usage    : $RAM_USED/$RAM_TOTAL ($RAM_PERC %)
Disk Usage      : $DISK_USED/$DISK_TOTAL ($DISK_PERC)
CPU Load        : $CPU_LOAD
Last Boot       : $LAST_BOOT
LVM use         : $LVM_STATUS
Connections TCP : $TCP established
Users logged    : $USER_LOG
Network         : $IP_ADDR ($MAC_ADDR)
Sudo            : $SUDO_LOG commands used
------------------------------------------------"
