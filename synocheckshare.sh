#!/bin/sh

if [ "$1" == "--vol-mounted" ]; then
    m=$(fdisk -l | grep "$3" | grep "exFAT")
    if [ -z "$m" ]; then
        /usr/syno/bin/synocheckshare.bin "$@"
    fi
else
    /usr/syno/bin/synocheckshare.bin "$@"
fi
