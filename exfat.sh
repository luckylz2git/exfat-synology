#!/bin/sh

option=$1
login=$2
password=$3
partition=$4

case "${option}" in
"mount")
  (sleep 1;echo $login;sleep 1;echo $password;echo /usr/local/exfat-synology/mount.sh $partition;sleep 2;exit)|telnet 127.0.0.1
  ;;
"unmount")
  (sleep 1;echo $login;sleep 1;echo $password;echo /usr/local/exfat-synology/unmount.sh $partition;sleep 2;exit)|telnet 127.0.0.1
  ;;
"autorun")
  (sleep 1;echo $login;sleep 1;echo $password;echo /usr/local/exfat-synology/autorun.sh $partition;sleep 2;exit)|telnet 127.0.0.1
  ;;
"manual")
  (sleep 1;echo $login;sleep 1;echo $password;echo /usr/local/exfat-synology/manual.sh;sleep 2;exit)|telnet 127.0.0.1
  ;;
"eject")
  (sleep 1;echo $login;sleep 1;echo $password;echo /usr/local/exfat-synology/eject.sh $partition;sleep 5;exit)|telnet 127.0.0.1
  ;;
*)
  echo "Usage:"
  echo "exfat.sh [mount|unmount|auto|manual|eject] [login] [password] [path/to/mount/point]"
  ;;
esac
