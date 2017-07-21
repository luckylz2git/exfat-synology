#Automatically Rename Photos & Videos

**Functionality**

This function runs after [usbsync](https://github.com/luckylz2git/exfat-synology/tree/master/usbsync), and is based on the opensource tool: [ExifTool by Phil Harvey](https://sno.phy.queensu.ca/~phil/exiftool/).

I use Nikon DSLRs, the exif tags maybe different to others brand. So I only add the functions I need here. Further usages please refer to ExifTool website.

1. Nikon RAW files(*.NEF) in the sub directory (like *ND*, e.g. 100ND810, 101ND810) of [usbsync] ImportDir (/volume1/PhotoImported), auto rename to DSC_XXXXX($####).NEF And move to new directory like DSLR_Model_Number/NEF.YYYYMM.
```
XXXXX - Shutter Count
$ - Color Space, S:sRGB, A:Adobe RGB
#### - Original File Sequence Number
YYYYMM - Original Year & Month
```
Nikon D810 original NEF files shot at 2017-07:
```
/volume1/PhotoImported/100ND810/DSC_0001.NEF (Shutter Count 9123)
/volume1/PhotoImported/100ND810/DSC_0002.NEF (Shutter Count 9124)
/volume1/PhotoImported/100ND810/DSC_0003.NEF (Shutter Count 9125)
/volume1/PhotoImported/100ND810/DSC_0004.NEF (Shutter Count 9126)
/volume1/PhotoImported/100ND810/DSC_0005.NEF (Shutter Count 9127)
...
```
After rename & move to new directory:
```
/volume1/PhotoImported/NIKON D810/NEF.201707/DSC_09123(S0001).NEF
/volume1/PhotoImported/NIKON D810/NEF.201707/DSC_09124(S0002).NEF
/volume1/PhotoImported/NIKON D810/NEF.201707/DSC_09125(S0003).NEF
/volume1/PhotoImported/NIKON D810/NEF.201707/DSC_09126(S0004).NEF
/volume1/PhotoImported/NIKON D810/NEF.201707/DSC_09127(S0005).NEF
...
```

2. Nikon Video files(*.MOV) in the sub directory (like *ND*, e.g. 100ND810, 101ND810) of [usbsync] ImportDir (/volume1/PhotoImported), auto rename to DSC_YYYYMMDD_HHMMSS(####).MOV And move to new directory like DSLR_Model_Number/MOV.YYYYMM. Because there is no [Shutter Count] tag in video files.
```
YYYYMMDD_HHMMSS - Original Year, Month, Day, Hour, Minute, Second
#### - Original File Sequence Number
YYYYMM - Original Year & Month
```

**How To Setup**

Need to use root account via SSH or Telnet.

**[ 1 ]** Install ipkg & some supporting tools:
```
wget -P /tmp/ http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/syno-i686-bootstrap_1.2-7_i686.xsh
chmod +x /tmp/syno-i686-bootstrap_1.2-7_i686.xsh
sh /tmp/syno-i686-bootstrap_1.2-7_i686.xsh
rm /tmp/syno-i686-bootstrap_1.2-7_i686.xsh
ipkg update
ipkg install perl
ipkg install automake
ipkg install make
```

**[ 2 ]** Compile & install exiftool

Replace the exiftool source code version, if any new version is released on the website.
```
wget -P /tmp/ https://sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.59.tar.gz --no-check-certificate
cd /tmp
gzip -dc Image-ExifTool-10.59.tar.gz | tar -xf -
cd Image-ExifTool-10.59
perl Makefile.PL
make test
make install
exiftool -ver
```

**[ 3 ]** Install exifname
```
wget -P /tmp/ https://github.com/luckylz2git/exfat-synology/raw/master/exifname/exifname.sh --no-check-certificate
chmod 755 /tmp/exifname.sh
mv /tmp/exifname.sh /volume1/PhotoImported/exifname.sh
```

**How To Uninstall**

SSH or Telnet:
```
rm -f /volume1/PhotoImported/exifname.sh
```
