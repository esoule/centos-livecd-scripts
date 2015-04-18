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
install_service_file livesys-inst-02
install_service_file livesys-inst-98

# list weak kernel modules
find /lib/modules/ \( -type f -o -type l \) -name '*.ko' | grep '\(extra\|weak\)' | LANG=en_CA.UTF-8 sort

# go ahead and pre-make the man -k cache (#455968)
/usr/sbin/makewhatis -w

# generate manifest
/bin/rpm -q --all --queryformat '%{NAME}\t%{ARCH}\n'    \
    | LANG=en_CA.UTF-8 sort -t $'\t' --key=1,1 --key=2,2    \
    > ${FTDIR}/centos-installed-packages-summary.txt
/bin/rpm -q --all --queryformat '%{NAME}\t%{ARCH}\t%{VERSION}-%{RELEASE}\t%{VENDOR}\n'    \
    | LANG=en_CA.UTF-8 sort -t $'\t' --key=1,1 --key=2,2    \
    > ${FTDIR}/centos-installed-packages-detail.txt

# save a little bit of space at least...
rm -f /var/lib/rpm/__db*
rm -f /boot/initrd*
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

# convince readahead not to collect
rm -f /.readahead_collect
touch /var/lib/readahead/early.sorted

