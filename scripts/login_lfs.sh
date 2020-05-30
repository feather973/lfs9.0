#!/bin/bash

export LFS=/mnt/lfs

# UNSHARE AND CHROOT
# dev,  devpts,  proc,  sys,  run 
unshare --mount --setgroups allow $(pwd)/enter-chroot.sh
