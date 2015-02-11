#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
	echo ">>UNINSTALL<< ────── Helper mouse module installer ───────"
	echo ">>UNINSTALL<< This script needs root permissions, login as root"
	echo ">>UNINSTALL<< or run sudo $0 "
	echo ">>UNINSTALL<< Thanks and have a good day!"
	exit
fi

source ./dkms.conf

command -v dkms >/dev/null 2>&1 || { echo ">>UNINSTALL<< dkms is required but it's not installed. Aborting."; exit 1; }

dkms status ${PACKAGE_NAME}/${PACKAGE_VERSION} -k all | grep added
[[ $? -eq 0 ]] || { echo ">>UNINSTALL<< DKMS module ${PACKAGE_NAME}/${PACKAGE_VERSION} is not installed. Aborting..."; exit 1; }

echo ">>UNINSTALL<< Removing the patched DKMS module 'psmouse'"
dkms remove -m ${PACKAGE_NAME}/${PACKAGE_VERSION} --all 

echo ">>UNINSTALL<< Reverting back to the stock 'psmouse' module of kernel $(uname -r)"
MDIR="/usr/lib/modules/$(uname -r)"
if [ ! -d "$MDIR" ]; then
    MDIR="/lib/modules/$(uname -r)"
    if [ ! -d "$MDIR" ]; then
        echo ">>UNINSTALL<< Error: Could not find module directory!" >&2
        exit 1
    fi
fi
[[ -f ${MDIR}/kernel/drivers/input/mouse/psmouse.ko.orig ]] || { echo ">>UNINSTALL<< No backup file was found for the 'psmouse' kernel module."; exit 1; }
mv ${MDIR}/kernel/drivers/input/mouse/psmouse.ko.orig ${MDIR}/kernel/drivers/input/mouse/psmouse.ko

echo ">>UNINSTALL<< Attempting to load the original 'psmouse' module"
rmmod psmouse && modprobe psmouse 
[[ $? -eq 0 ]] || { echo ">>UNINSTALL<< Failed tp load the original 'psmouse' module. Aborting..."; exit 1; }

echo ">>UNINSTALL<< Propagating the updates in the initramfs"
update-initramfs -u -k all

echo ">>UNINSTALL<< DONE!"
