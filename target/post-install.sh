#!/bin/bash
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts"
TFILES=${ROOT_CLS_TOP_DIR}/target/files
FTDIR=${ROOT_CLS_TOP_DIR}/from-target

echo "###################################################################"
echo "## Creating the livesys init script"
echo "###################################################################"

##
## /root/.gitconfig
##
cat <<"__GITCONFIG__" >/root/.gitconfig
[user]
	name = root at localhost
	email = root@localhost.localdomain
__GITCONFIG__

chmod 0644 /root/.gitconfig
/sbin/restorecon /root/.gitconfig

##
## record initial state of /etc during live image generation
##
/bin/bash -x ${ROOT_CLS_TOP_DIR}/target/etckeeper-commit-early.sh

# workaround avahi segfault (#279301)
touch /etc/resolv.conf
/sbin/restorecon /etc/resolv.conf

#
# fix boot warning "GOTO 'pulseaudio_check_usb' has no matching label"
# NOTE: temporary fix, taken from pulseaudio-0.9.21-21.el6
#
sed -i -e '/GOTO="pulseaudio_check_usb"/d' /lib/udev/rules.d/90-pulseaudio.rules
/sbin/restorecon /lib/udev/rules.d/90-pulseaudio.rules

#
# move firstboot to position 97 from 99, so that
# other firstinst scripts may execute after it
#
sed -i -e 's,chkconfig: 35 99 95,chkconfig: 35 97 95,' /etc/rc.d/init.d/firstboot
/sbin/restorecon /etc/rc.d/init.d/firstboot
/sbin/chkconfig --del firstboot
/sbin/chkconfig --add firstboot

# list weak kernel modules
find /lib/modules/ \( -type f -o -type l \) -name '*.ko' | grep '\(extra\|weak\)' | LANG=en_CA.UTF-8 sort

# go ahead and pre-make the man -k cache (#455968)
/usr/sbin/makewhatis -w

# generate manifest
/bin/bash -x ${ROOT_CLS_TOP_DIR}/target/gen-package-list.sh ${FTDIR}

# save a little bit of space at least...
rm -f /var/lib/rpm/__db*
rm -f /boot/initrd*
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

# convince readahead not to collect
rm -f /.readahead_collect
touch /var/lib/readahead/early.sorted

