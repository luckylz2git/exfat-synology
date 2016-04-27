#!/bin/sh

unmount_all()
{
  for mnt in `ps | grep mount.exfat-fuse | grep "\-o nonempty" | awk '{ print $7 }'`
  do
    if [ "${mnt}" != "" ]; then
      vol=`ps | grep mount.exfat-fuse | grep "\-o nonempty" | grep $mnt | awk '{ print $6 }'`
      echo "Try to unmount:" $vol "on" $mnt
      umount $mnt
    fi
  done
}

unmount_one()
{
  vol=`ps | grep mount.exfat-fuse | grep "\-o nonempty" | grep $one | awk '{ print $6 }'`
  echo "Try to unmount:" $vol "on" $one
  umount $one
}

one=$1
if [ "${one}" == "" ]; then
  unmount_all
else
  unmount_one
fi
