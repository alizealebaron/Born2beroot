#!/bin/bash

# Déclarations des constantes
ARCH=$(uname -a)
PCPU=$(lscpu | grep "^CPU(s):" | grep -o '[0-9]\+')
VCPU=$(cat /proc/cpuinfo | grep processor | wc -l)

RAM_USED=$(free -h | grep "Mem" | tr -s ' ' | cut -d ' ' -f 3)
RAM_TOTAL=$(free -h | grep "Mem" | tr -s ' ' | cut -d ' ' -f 2)
RAM_PERC=$(( 100 * RAM_USED / RAM_TOTAL ))

DISK_USED=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 3)
DISK_TOTAL=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 2)
DISK_PERC=$(df -h --total | grep "total" | tr -s ' ' | cut -d ' ' -f 5)

CPU_LOAD=$(top -bn1 | grep "Cpu" | cut -d ' ' -f 3)
LAST_BOOT=$(who -b | tr -s ' ' | cut -d ' ' -f 4-5)
TCP=$(cat /proc/net/sockstat | grep TCP | cut -d ' ' -f 3)
USER_LOG=$(who | wc -l)

IP_ADDR=$(hostname -I)
MAC_ADDR=$(ip addr | grep link/ether | cut -d ' ' -f 3)

SUDO_LOG=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

if lsblk | grep "lvm"; then
    LVM_STATUS="Yep"
else
    LVM_STATUS="Nop"
fi

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