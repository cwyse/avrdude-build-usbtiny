#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
BACKUP_DIR=${HOME}/Prusa-i3-backup
AVRDUDE=${SCRIPT_DIR}/bin/avrdude
AVRDUDE_CONF=${SCRIPT_DIR}/etc/avrdude.conf

# OUTPUT_FORMAT:
#    i - Intel hex
#    r - Binary
#    h - Hexadecimal
OUTPUT_FORMAT=i

tput clear

echo
echo ====================================
echo Prusa-i3 ATMega1284p Firmware Backup
echo ====================================
echo

echo ------------------------------------
echo Backing up flash memory
echo ------------------------------------
echo
mem_params=
operation=r
for memtype in eeprom flash lfuse hfuse efuse signature calibration; do
  mem_params="${mem_params} -U ${memtype}:${operation}:${BACKUP_DIR}/ATMega1284p-${memtype}.hex:${OUTPUT_FORMAT}"
done

mkdir -p ${BACKUP_DIR}
echo ${AVRDUDE} -p m1284p -c usbtiny -C ${AVRDUDE_CONF} -n -F ${mem_params}
sudo ${AVRDUDE} -p m1284p -c usbtiny -C ${AVRDUDE_CONF} -n -F ${mem_params}

echo
echo ====================================
echo Prusa-i3 Firmware Backup Complete
echo ====================================
echo
