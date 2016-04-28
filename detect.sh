#!/bin/sh

detect()
{
  USBTAB=/tmp/usbtab
  #get all usb devices
  if [ -e $USBTAB ]; then
    USBDEV=`cat $USBTAB | grep sd[u-z]= | awk -F'=' '{ print $1 }'`
  else
    USBDEV=''
  fi
  for tab in $USBDEV
  do
    #get usb disk name
    USBDSK=/dev/$tab
    #already mount
    if [ -e /tmp/exfatab ]; then
      EXTAB=`cat /tmp/exfatab | grep $USBDSK`
    else
      EXTAB=''
    fi
    #mount as normal
    if [ "${EXTAB}" == "" ]; then
      NORMAL=`mount | grep $USBDSK[0-9] | awk '{ print $1 }'`
    else
      NORMAL=$EXTAB
    fi
    #not yet mount
    if [ "${NORMAL}" == "" ]; then
      #exfat is recognized as HPFS/NTFS
      USBVOL=`fdisk -l | grep $USBDSK[0-9] | grep HPFS/NTFS | awk '{ print $1 }'`
      if [ "${USBVOL}" != "" ]; then
        EXVOL=`ps | grep mount.exfat-fuse | grep $USBVOL`
        EXMNT=`ps | grep mount.exfat-fuse | grep $USBMNT`
        if [ "${EXVOL}" == "" ] && [ "${EXMNT}" == "" ]; then
          WAIT=60
          echo `date` ": found exfat disk" $USBVOL >> /tmp/exfatdebug
          /usr/local/exfat-synology/mount.sh $USBMNT $USBVOL
        fi
      fi
    fi
  done
  if [ "${USBDEV}" == "" ]; then
    WAIT=10
  fi
}

USBMNT=$1
echo `date` ": start autorun mode, mount point" $1 >> /tmp/exfatdebug
#wait 10 seconds to run the detecting script
WAIT=10
sleep $WAIT
while [ 1 ]; do
  sleep $WAIT
  detect
done

