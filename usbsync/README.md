#Incremental import for DSLR photos & videos

**Functionality**

Differ from [USB Copy] package of Synology, which will reimport the files again if user move or delete files in the Destination Directory.

[usbsync] uses another mechanism to proceed the incremental import. Once any file is imported, [usbsync] won't import it again, even the file is moved or deleted from the Import Directory. This is more suitable for DSLR photos & videos import workflow. Because after importing data into the NAS, users always like to rename the files and create new folders to keep different photos & videos.

**How To Setup**

**[ 1 ]** Go to Synology DiskStation, [Control Panel] -> [Shared Folder], create a shared folder on volume1, e.g. PhotoImported.

**[ 2 ]** Copy the the following files to related directories, via SSH or Telnet:
```
wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/usbsync/usbsync.sh --no-check-certificate
chmod 755 /tmp/usbsync.sh
mv /tmp/usbsync.sh /bin/usbsync.sh

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

**[3]** Edit usbsnyc.cfg use any text editors:

Enable or disable auto sync function
```
AutoSync:[true | false]
```

Enable or disable auto unmount after sync complete. If enabled, the mount point /volume*/usbexfat/usbshare* will be deleted after unmount.
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

Destination import target directory
```
ImportDir:/volume1/PhotoImported
```

Register USB Hash to Sync.
If multiple USB need to be synced, input multiple lines of USB Hash as the following:
```
USBHash:[usb_hash_value1][,usb_dev_info1]
USBHash:[usb_hash_value2][,usb_dev_info2]
...
USBHash:d1912eac1eb562007524467b58f3423f,EXAMPLE_USB_DEVICE1
USBHash:e1912eac1eb562007524467b58f3423f,EXAMPLE_USB_DEVICE2
...
```
P.S. - Copy this from file usbhash.log in ImportDir (/volume1/PhotoImported) after USB plug-in to the NAS. The [usb_dev_info1] is optional input by user, to discribe the USB device. The contents of usbhash.log looks like:
```
USB Disk: /dev/sdu
Device: /dev/sdu1
USBHash: d1912eac1eb562007524467b58f3423f
```
Eject & plug-in the USB device again, the sync will start. Repeat this step to register another USB device.

**[4]** Verify import result:

The latest import log will keep in ImportDir (/volume1/PhotoImported) named import_latest.log, old import history log named import_history.log

**How To Uninstall**

SSH or Telnet:
```
rm -f /bin/usbsync.sh
```
