#!/bin/bash

TFILES=/root/centos-livecd-scripts/target/files
FTDIR=/root/centos-livecd-scripts/from-target

echo "###################################################################"
echo "## Creating the livesys init script"
echo "###################################################################"

install_service_file()
{
    local svc_name=$1
    install -p -m 0755 ${TFILES}/etc/rc.d/init.d/${svc_name} /etc/rc.d/init.d/${svc_name}
    /sbin/restorecon /etc/rc.d/init.d/${svc_name}
    /sbin/chkconfig --add ${svc_name}
    return 0
}

# workaround avahi segfault (#279301)
touch /etc/resolv.conf
/sbin/restorecon /etc/resolv.conf

install_service_file livesys
# bah, hal starts way too late
install_service_file livesys-late

# custom files, to be run on LiveDVD and first hard drive boot
install_service_file livesys-inst-early
install_service_file livesys-inst-late

#
# fix boot warning "GOTO 'pulseaudio_check_usb' has no matching label"
# NOTE: temporary fix, taken from pulseaudio-0.9.21-21.el6
#
sed -i -e '/GOTO="pulseaudio_check_usb"/d' /lib/udev/rules.d/90-pulseaudio.rules
/sbin/restorecon /lib/udev/rules.d/90-pulseaudio.rules

# list weak kernel modules
find /lib/modules/ \( -type f -o -type l \) -name '*.ko' | grep '\(extra\|weak\)' | LANG=en_CA.UTF-8 sort

# go ahead and pre-make the man -k cache (#455968)
/usr/sbin/makewhatis -w

# generate manifest
/bin/bash -x /root/centos-livecd-scripts/target/gen-package-list.sh ${FTDIR}

# save a little bit of space at least...
rm -f /var/lib/rpm/__db*
rm -f /boot/initrd*
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

# convince readahead not to collect
rm -f /.readahead_collect
touch /var/lib/readahead/early.sorted

