#!/bin/bash

source /root/centos-livecd-scripts/target/livesys-inst-functions

TFILES=/root/centos-livecd-scripts/target/files

##
## /etc/fstab
## add noatime mount option to ext2, ext3, ext4 filesystems
## NOTE: this takes effect on next boot only
##
if ! is_liveimg_run ; then
    sed -i -e 's!\(\sext[234]\s\+defaults\)\(\s\)!\1,noatime\2!;' /etc/fstab
    /sbin/restorecon /etc/fstab
fi
