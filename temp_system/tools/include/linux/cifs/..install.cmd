cmd_dest/include/linux/cifs/.install := /bin/sh scripts/headers_install.sh dest/include/linux/cifs ./include/uapi/linux/cifs cifs_mount.h; /bin/sh scripts/headers_install.sh dest/include/linux/cifs ./include/generated/uapi/linux/cifs ; touch dest/include/linux/cifs/.install
