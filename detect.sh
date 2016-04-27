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
    USBVOL=`fdisk -l | grep $USBDSK[0-9] | grep HPFS/NTFS | awk '{ print $1 }'`
    #exfat is recognized as HPFS/NTFS
    if [ "${USBVOL}" != "" ]; then
      #check normal mount list
      NORMAL=`mount | grep $USBVOL | awk '{ print $1 }'`
      if [ "${NORMAL}" == "" ]; then
        EXVOL=`ps | grep mount.exfat-fuse | grep $USBVOL`
        EXMNT=`ps | grep mount.exfat-fuse | grep $USBMNT`
        if [ -e /tmp/exfatab ]; then
          EXTAB=`cat /tmp/exfatab`
        else
          EXTAB=''
        fi
        #blank means not yet mount
        if [ "${EXVOL}" == "" ] && [ "${EXMNT}" == "" ] && [ "${EXTAB}" == "" ]; then
          echo $USBVOL $USBMNT > /tmp/exfatab
          WAIT=60
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
#wait 10 seconds to run the detecting script
WAIT=10
sleep $WAIT
while [ 1 ]; do
  sleep $WAIT
  detect
done

