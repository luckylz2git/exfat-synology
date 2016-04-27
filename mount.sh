#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Usage:"
  echo "mount.sh [path/to/mount/point] [path/to/usb/device/volume]"
  exit 0
fi

if [ "${2}" == "" ]; then
  for usb in `cat /tmp/usbtab | grep usb | awk -F'=' '{ print $1 }'`
  do
    dev="/dev/${usb}"
    vol=`fdisk -l | grep $dev | grep 'HPFS/NTFS' | awk '{ print $1 }'`
    mnt=`mount | grep $vol`
    if ["${mnt}" == ""]; then
      echo "Try to mount:" $vol "on" $1
      mount.exfat-fuse $vol $1 -o nonempty
      echo $vol $1 > /tmp/exfatab
      sleep 1
      ls $1
      exit 0
    fi
  done
else
  echo "Try to mount:" $2 "on" $1
  mount.exfat-fuse $2 $1 -o nonempty
  echo $2 $1 > /tmp/exfatab
  sleep 1
  ls $1
fi
