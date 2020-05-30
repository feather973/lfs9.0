# lfs9.0
lfs 9.0 + uefi usb boot

how to login
    
    enter-chroot.sh   :  change /dev/sdc1 to user usb device name
    sudo -S ./login_lfs.sh

![Alt text](https://github.com/feather973/lfs9.0/blob/master/screenshot/login.png?raw=true "Optional Title")

directory

    archives/sources  :  lfs temporary system sources and patchs,  wget-list,  md5sums
    scripts           :  version-check.sh,  login_lfs.sh,  enter-chroot.sh
    manual            :  host_requirement,  user_setting,  virtualbox_setting
    temp_system/tools
        bin
        {lib,lib64}
        include
        etc
        libexec
        sbin
        share
        var
        x86_64-lfs-linux-gnu
        x86_64-pc-linux-gnu
