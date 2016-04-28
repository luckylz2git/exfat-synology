#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage:"
  echo "autorun.sh [path/to/mount/point]"
  exit 0
fi

USBMNT=$1
BOOTSH=/usr/local/etc/rc.d/S99zexfat.sh

echo \#\!/bin/sh > $BOOTSH
echo /usr/local/exfat-synology/detect.sh $USBMNT \& >> $BOOTSH
chmod 755 $BOOTSH

echo `date` ": change to autorun mode, mount point" $USBMNT >> /tmp/exfatdebug
