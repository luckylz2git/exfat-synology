#exfat-synology auto mount

> Perfect shell scripts to automatic mount/unmount exfat disk partition on Synology DiskStation NAS (x86 platform).
> Currently support only one exfat partition.

**Tested on VitualBox + Jun's Mod V1.02-alpha + DS3615xs + DSM 6.1-15047 Update 1, use this at your own risks.**

##How-To Guide

**Initialize Setup**

**[ 1 ]** Enabled Telnet service on Synology DiskStation, [Control Panel] -> [Terminal & SNMP]: [Enable Telnet service] & [Enable SSH service]; 

**[ 2 ]** SSH to NAS & enable root account;
```
ssh admin@ipaddress

sudo su -
synouser --setpw root your_new_root_password
```

**[ 3 ]** Login NAS via SSH or Telnet, using root account :

```
wget -P /tmp/ http://mirrors.kernel.org/ubuntu/pool/universe/f/fuse-exfat/exfat-fuse_1.2.3-1_amd64.deb
dpkg -x /tmp/exfat-fuse_1.2.3-1_amd64.deb /tmp/exfat-fuse/
cp /tmp/exfat-fuse/sbin/mount.exfat-fuse /bin/
```

**P.S.**

It been tested Synology x86 platform, can directly use ubuntu amd64 version exfat-fuse bin file to mount exfat disk partition.

I also keep exfat-fuse_1.2.3-1_amd64.deb file in my repository.

**[ 4 ]** Go back to Synology DiskStation, [Control Panel] -> [Shared Folder], create a shared folder on volume1, e.g. usbexfat. Will create a sub-dir /volume1/usbexfat/usbshare[1...n] will be used as mountpoint, usbshare[1...n] same as the volumeUSB[1...n] mountpoint; 

**[ 5 ]** 
