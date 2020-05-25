#!/bin/bash

export LFS=/mnt/lfs

# UNSHARE AND CHROOT
# dev,  devpts,  proc,  sys,  run 
unshare --mount --setgroups allow /home/lfs/enter-chroot.sh
