#!/bin/sh

unmount_all()
{
  for mnt in `ps | grep mount.exfat-fuse | grep "\-o nonempty" | awk '{ print $7 }'`
  do
    if [ "${mnt}" != "" ]; then
      vol=`cat /tmp/exfatab | grep $mnt | awk '{ print $1 }'`
      umount $mnt
      echo `date` ": unmount" $vol "on" $mnt >> /tmp/exfatdebug
    fi
  done
}

unmount_one()
{
  vol=`cat /tmp/exfatab | grep $one | awk '{ print $1 }'`
  umount $one
  echo `date` ": unmount" $vol "on" $one >> /tmp/exfatdebug
}

one=$1
if [ "${one}" == "" ]; then
  unmount_all
else
  unmount_one
fi
