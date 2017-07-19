#!/bin/sh

USB=$(echo "$@" | grep "volumeUSB")
#usb types
if [ -n "$USB" ]; then
    USBSYNC="/bin/usbsync.sh"
    #exfat partition
    if [ "$2" == "exfat" ]; then
        m=$(/bin/mount.bin | grep "$5")
        if [ -z "$m" ]; then
            n="$6"
            n=${n#*/volumeUSB}
            n=${n%%/usbshare}
            MOUNTPOINT="/volume1/usbexfat/usbshare$n"
            /bin/mount.exfat-fuse "$5" "$MOUNTPOINT" -o nonempty
            if [ -f "$USBSYNC" ]; then
                "$USBSYNC" "$5" "$MOUNTPOINT" &
            fi
        fi
    #fat32 partition
    elif [ "$2" == "vfat" ]; then
        /bin/mount.bin "$@" &
        if [ -f "$USBSYNC" ]; then
            "$USBSYNC" "$5" "$6" &
        fi
    #others partition
    else
        /bin/mount.bin "$@"      
    fi
#other types
else
    /bin/mount.bin "$@"
fi
