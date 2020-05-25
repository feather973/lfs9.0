# lfs9.0
lfs 9.0 + uefi usb boot

how to meet host requirement in ubuntu 16.04 LTS



how to build lfs temp system
environment setting for lfsbuild user

    sudo mkdir -v $LFS/tools
    sudo ln -sv /mnt/lfs/tools/ /
    sudo groupadd lfsbuild
    sudo useradd -s /bin/bash -g lfsbuild -m -k /dev/null lfsbuild
    sudo passwd lfsbuild
    sudo chown -v lfsbuild $LFS/tools
    sudo chown -v lfsbuild $LFS/sources
    su - lfsbuild

    cat > ~/.bash_profile << "EOF"
    exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
    EOF
    
    cat > ~/.bashrc << "EOF"
    set +h
    umask 022
    LFS=/mnt/lfs
    LC_ALL=POSIX
    LFS_TGT=$(uname -m)-lfs-linux-gnu
    PATH=/tools/bin:/bin:/usr/bin
    export LFS LC_ALL LFS_TGT PATH
    EOF

how to chroot lfs temp system ( /dev/sdb1 )
with lfs build user ( lfsbuild )

    cat > login_lfs.sh << "EOF
    #!/bin/bash
    whoami
    
    # IF NOT ROOT, LOGIN TO ROOT
    [ "$UID" -eq 0 ] || exec sudo $0 "$@"
    
    # ROOT USER NEED TO KNOW LFS mount location
    export LFS=/mnt/lfs
    
    # MOUNT FILESYSTEMS AND CHROOT TO LFS
    set -- "mount -v -t ext4 /dev/sdb1 $LFS" \
    "mount -v --bind /dev $LFS/dev" \
    "mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620" \
    "mount -vt proc proc $LFS/proc" \
    "mount -vt sysfs sysfs $LFS/sys" \
    "mount -vt tmpfs tmpfs $LFS/run" \
    "mkdir -pv $LFS/$(readlink $LFS/dev/shm)"
    
    for cmd in "$@"; do
        eval "$cmd"
    done
    
    chroot "$LFS" /tools/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h
    EOF
    
    sudo -S ./login_lfs.sh
