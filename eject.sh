#!/bin/sh
USBMNT=$1
USBVOL=`cat /tmp/exfatab | awk '{ print $1 }'`
/usr/local/exfat-synology/unmount.sh $USBMNT
sleep 2
eject -vs $USBVOL
echo `date` ": eject exfat disk" $USBVOL >> /tmp/exfatdebug
echo > /tmp/exfatab
