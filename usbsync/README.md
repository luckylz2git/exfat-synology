#Incremental backup for DSLR photos

**[ 1 ]** Go to Synology DiskStation, [Control Panel] -> [Shared Folder], create a shared folder on volume1, e.g. PhotoImported.

**[ 2 ]** Copy the files from this repository, and override some system files
```
wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.sh --no-check-certificate
chmod 755 /tmp/usbsync.sh
mv /bin/usbsync.sh

wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.cfg --no-check-certificate
chmod 666 /tmp/usbsync.cfg
mv /tmp/usbsync.cfg /volume1/PhotoImported/usbsync.cfg
```

