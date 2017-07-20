#Incremental backup for DSLR photos

**[ 1 ]** Go to Synology DiskStation, [Control Panel] -> [Shared Folder], create a shared folder on volume1, e.g. PhotoImported.

**[ 2 ]** Copy the the following files to related directories
```
wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.sh --no-check-certificate
chmod 755 /tmp/usbsync.sh
mv /bin/usbsync.sh

wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.cfg --no-check-certificate
chmod 666 /tmp/usbsync.cfg
mv /tmp/usbsync.cfg /volume1/PhotoImported/usbsync.cfg
```
P.S. - directory of usbsync.cfg is fixed by default, can be modified in usbsync.sh
```
...
DefaultDir=/volume1/PhotoImported
...
```

**[3]** Setup usbsnyc.cfg

Enable or disable auto sync function
```
AutoSync:[true | false]
```

Enable or disable auto unmount after sync complete
```
AutoUnmount:[true | false]
```

Source sync sub directory of USB, default is DCIM
```
SourceDir:DCIM
```

File extension filter that will be synced, semicolon (;) seperated. Default (*) means sync all files
```
FileExtension:*
or
FileExtension:nef;jpg;mov
```

Backup target directory
```
BackupDir:/volume1/PhotoImported
```

Filter USB UUID Can Run Sync. 
If multiple USB need to be synced, input multiple lines of USB UUID as the following:
```
IncludeUUID:[usb_uuid1][,usb_infomation1]
IncludeUUID:[usb_uuid2][,usb_infomation2]
...
IncludeUUID:b1912eac1eb562007524467b58f3423f,EXAMPLE_USB_UUID1
IncludeUUID:c1912eac1eb562007524467b58f3423f,EXAMPLE_USB_UUID2
...
```
P.S. - Copy this from file usb-uuid.log in BackupDir (/volume1/PhotoImported) after USB plug-in to the NAS. The [usb_infomation] is optional to discribe the USB Information.
``
example usb-uuid.log

USB Disk: /dev/sdu
Device: /dev/sdu1
UUID: b1912eac1eb562007524467b58f3423f
```
