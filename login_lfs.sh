#!/bin/bash

export LFS=/mnt/lfs

# UNSHARE AND CHROOT
unshare -U -r -m --propagation slave /home/lfs/enter-chroot.sh
