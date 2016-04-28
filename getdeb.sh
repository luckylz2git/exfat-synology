#!/bin/sh

wget -P /tmp/ http://mirrors.kernel.org/ubuntu/pool/universe/f/fuse-exfat/exfat-fuse_1.0.1-1_i386.deb
dpkg -x /tmp/exfat-fuse_1.0.1-1_i386.deb /tmp/exfat-fuse/
cp /tmp/exfat-fuse/sbin/mount.exfat-fuse /usr/bin/
