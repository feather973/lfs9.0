#!/bin/bash

whoami

# IF NOT ROOT, LOGIN TO ROOT
[ "$UID" -eq 0 ] || exec sudo $0 "$@"

# ROOT USER NEED TO KNOW LFS mount location
export LFS=/mnt/lfs

# MOUNT FILESYSTEMS AND LOGIN TO LFS
set -- "mount -v -t ext4 /dev/sdb1 $LFS" \
"/sbin/swapon -v /dev/sdb5" \
"mount -v --bind /dev $LFS/dev" \
"mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620" \
"mount -vt proc proc $LFS/proc" \
"mount -vt sysfs sysfs $LFS/sys" \
"mount -vt tmpfs tmpfs $LFS/run" \
"mkdir -pv $LFS/$(readlink $LFS/dev/shm)" \
"su - lfs"

for cmd in "$@"; do 
  eval "$cmd"
done
