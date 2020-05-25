# lfs9.0
lfs 9.0 + uefi usb boot

how to meet host requirement in ubuntu 16.04 LTS

: 

how to build lfs temp system

: 

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


how to login lfs temp system ( /dev/sdb1 ) with lfs build user ( lfsbuild )

: sudo -S ./login_lfs.sh
