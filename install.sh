#!/bin/sh

filepath=$1

cd /tmp/
wget http://mirrors.kernel.org/ubuntu/pool/universe/f/fuse-exfat/exfat-fuse_1.0.1-1_i386.deb
dpkg -x exfat-fuse_1.0.1-1_i386.deb exfat-fuse
cp exfat-fuse/sbin/mount.exfat-fuse /usr/bin/mount.exfat-fuse
mkdir -p /usr/local/exfat-synology/
cp -r $filepath/*.sh /usr/local/exfat-synology/
chmod 755 -R /usr/local/exfat-synology/*.sh
