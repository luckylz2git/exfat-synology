#!/bin/sh

if [ -f /bin/mount.bin ]; then
    wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/mount.sh --no-check-certificate
    chmod 755 /tmp/mount.sh
    mv /tmp/mount.sh /bin/mount
fi

if [ -f /usr/syno/bin/synocheckshare.bin ]; then
    wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/synocheckshare.sh --no-check-certificate
    chmod 755 /tmp/synocheckshare.sh
    mv /tmp/synocheckshare.sh /usr/syno/bin/synocheckshare
fi

if [ -f /bin/usbsync.sh ]; then
    wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.sh --no-check-certificate
    chmod 755 /tmp/usbsync.sh
    mv /tmp/usbsync.sh /bin/usbsync.sh
fi

DefaultDir=/volume1/PhotoImported
Settings=$DefaultDir/usbsync.cfg
if [ -f $Settings ]; then
    ImportDir=$(cat "$Settings" | grep 'ImportDir')
    if [ -n "$ImportDir" ]; then
        DestDir=${ImportDir#*:}
    else
        DestDir=$DefaultDir
    fi

    if [ -f $DestDir/exifname.sh ]; then
        wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/exifname/exifname.sh --no-check-certificate
        chmod 755 /tmp/exifname.sh
        mv /tmp/exifname.sh $DestDir/exifname.sh
    fi
fi
