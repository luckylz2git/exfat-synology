#exfat-synology

##Perfect shell scripts to manual/automatic mount/unmount exfat disk partition on Synology DiskStation NAS (x86 platform).

###Tested on VitualBox + XPEnBoot + DS3615xs + DSM 5.2 5644 Update 8, use this at your own risks.

#How-To Guide

##Initialize Setup

####1. Enabled Telnet service on Synology DiskStation, [Control Panel] -> [Terminal & SNMP] -> [Enable Telnet service];

####2. Download this repository zip file, extract all shell(*.sh) files, and save to your NAS shared folder /path_to/shell_files/;

####3. Login your NAS via Telnet, run the following commands to get exfat-fuse bin file:

```
mkdir -p /usr/local/exfat-synology/
cp /path_to/shell_files/*.sh /usr/local/exfat-synology/
chmod 755 /usr/local/exfat-synology/*.sh
wget -P /tmp/ http://mirrors.kernel.org/ubuntu/pool/universe/f/fuse-exfat/exfat-fuse_1.0.1-1_i386.deb
dpkg -x /tmp/exfat-fuse_1.0.1-1_i386.deb /tmp/fuse-exfat/
cp /tmp/fuse-exfat/sbin/mount.exfat-fuse /usr/bin/
```

####P.S.

It been tested Synology x86 platform, can directly use ubuntu i386 version exfat-fuse bin file to mount exfat disk partition.

I also keep exfat-fuse_1.0.1-1_i386.deb file in my repository.

####4. Go back to Synology DiskStation, [Control Panel] -> [Shared Folder], create a shared folder on volume1, e.g. usbexfat. And /volume1/usbexfat will be used as {mountpoint} of the following step; 

####5. Then [Control Panel] -> [Task Scheduler], create 4 tasks of User-defined script. In [General] tab, unchecked [Enabled] option; in [Schedule] tab, change to [Run on the following date] -> [Do not repeat] option.

Shell script usage:
```
/usr/local/exfat-synology/exfat.sh [option] [login] [password] [mountpoint]
option: mount | eject | autorun | manual
  mount: mount exfat disk partition manually;
  eject: safely eject exfat disk partition;
  autorun: turn on automatic mount function, after turn on need to reboot the NAS;
  manual: turn off automatic mount function, can use manual option to mount;
login: login name of Telnet, e.g. root;
password: login password of Telnet, e.g. 12345;
mountpoint: mount point of exfat disk partition, e.g. /volume1/usbexfat
```

Task 1 name: mount-exfat

Run command:
```
/usr/local/exfat-synology/exfat.sh mount root 12345 /volume1/usbexfat
```
Description: run this to manual mount exfat disk partition.

Task 2 name: eject-exfat

Run command:
```
/usr/local/exfat-synology/exfat.sh eject root 12345 /volume1/usbexfat
```
Description: safely eject exfat disk partition, do not use the Synology DiskStation Eject function!

Task 3 name: autorun-mode

Run command:
```
/usr/local/exfat-synology/exfat.sh autorun root 12345 /volume1/usbexfat
```
Description: turn on auto mount function, when exfat disk partition is plug-in, it will be automatic mounted. NAS reboot is needed to take effect.

Task 4 name: manual-mode

Run command:
```
/usr/local/exfat-synology/exfat.sh manual root 12345
```
Description: turn off auto mount function, you can still mount exfat disk partition by task: mount-exfat. No need to add mountpoint as a parameter, no need to reboot.

####6. Now the exfat mount functions are ready to use!

##Manual Mount & Eject

####1. Plug-in USB exfat disk partition;

####2. [Control Panel] -> [Task Scheduler], run the task [mount-exfat];

####3. Use the data on the mountpoint: /volume1/usbexfat;

####4. After use, close all the [File Station], and any connections to the mountpoint, e.g. Telnet;

####5. [Control Panel] -> [Task Scheduler], run the task [eject-exfat];

##Switch Between Auto and Manual Mode

####1. [Control Panel] -> [Task Scheduler], run the task [autorun-mode], reboot the NAS;

####2. Now the NAS is autorun-mode;

####3. [Control Panel] -> [Task Scheduler], run the task [manual-mode];

####4. Now the NAS is manual-mode;

##Auto Mount & Eject

####1. Make sure NAS is autorun-mode;

####2. Plug-in USB exfat disk partition, and wait for 15 seconds;

####3. Use the data on the mountpoint: /volume1/usbexfat;

####4. After use, close all the [File Station], and any connections to the mountpoint, e.g. Telnet;

####5. [Control Panel] -> [Task Scheduler], run the task [eject-exfat];
