#!/bin/bash

TFILES=/root/centos-livecd-scripts/target/files

echo "###################################################################"
echo "## Creating the livesys init script"
echo "###################################################################"

# workaround avahi segfault (#279301)
touch /etc/resolv.conf
/sbin/restorecon /etc/resolv.conf

install -p -m 0755 ${TFILES}/etc/rc.d/init.d/livesys /etc/rc.d/init.d/livesys
/sbin/restorecon /etc/rc.d/init.d/livesys
/sbin/chkconfig --add livesys

# bah, hal starts way too late
install -p -m 0755 ${TFILES}/etc/rc.d/init.d/livesys-late /etc/rc.d/init.d/livesys-late
/sbin/restorecon /etc/rc.d/init.d/livesys-late
/sbin/chkconfig --add livesys-late

# go ahead and pre-make the man -k cache (#455968)
/usr/sbin/makewhatis -w

# save a little bit of space at least...
rm -f /var/lib/rpm/__db*
rm -f /boot/initrd*
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

# convince readahead not to collect
rm -f /.readahead_collect
touch /var/lib/readahead/early.sorted

