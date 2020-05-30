#!/bin/bash

whoami

# IF NOT ROOT, LOGIN TO ROOT
[ "$UID" -eq 0 ] || exec sudo $0 "$@"

# ROOT USER NEED TO KNOW LFS mount location
export LFS=/mnt/lfs

# CHANGE /dev/sdc1 to your usb device name
set -- "mount -v -t ext4 /dev/sdc1 $LFS" \
"mount -v --bind /dev $LFS/dev" \
"mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620" \
"mount -vt proc proc $LFS/proc" \
"mount -vt sysfs sysfs $LFS/sys" \
"mount -vt tmpfs tmpfs $LFS/run" \
"mkdir -pv $LFS/$(readlink $LFS/dev/shm)" \

for cmd in "$@"; do 
  eval "$cmd"
done

echo LFS is $LFS

chroot "$LFS" /tools/bin/env -i \
        HOME=/root \
        TERM="$TERM" \
        PS1='(lfs chroot) \u:\w\$ ' \
        PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
        /tools/bin/bash --login +h
