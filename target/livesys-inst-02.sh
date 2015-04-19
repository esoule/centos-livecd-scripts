#!/bin/bash

source /root/centos-livecd-scripts/target/livesys-inst-functions

TFILES=/root/centos-livecd-scripts/target/files

##
## /root/.gitconfig
##
install -p -m 0644 ${TFILES}/root/.gitconfig /root/.gitconfig
/sbin/restorecon /root/.gitconfig

##
## record initial state of /etc
##
/bin/bash -x /root/centos-livecd-scripts/target/etckeeper-commit-02.sh

##
## /boot/grub/grub.conf
## remove hiddenmenu, increase timeout, fix "anaconda bluesky" title,
## set vga=791, do not show full-screen logo
## NOTE: this takes effect on next boot only
##
if ! is_liveimg_run ; then
    if [ -f /boot/grub/grub.conf -a -s /boot/grub/grub.conf ] ; then
        cp --archive /boot/grub/grub.conf /boot/grub/grub.conf.centos-livecd-scripts.orig

        sed -i -e 's!^\s*hiddenmenu\s*$!!;'    \
            -e 's!^\s*timeout=[0-9]\+\s*$!timeout=10!;'    \
            -e 's!title anaconda bluesky!title CentOS 6!;'    \
            -e 's!^\(\s*kernel.*\)\brhgb\b\(.*\)$!\1vga=791\2!;'    \
            /boot/grub/grub.conf

        chmod 0600 /boot/grub/grub.conf
        /sbin/restorecon /boot/grub/grub.conf
    fi
fi

##
## /etc/gitconfig
##
install -p -m 0644 ${TFILES}/etc/gitconfig /etc/gitconfig
/sbin/restorecon /etc/gitconfig

##
## disable avahi-daemon in both Live and hard drive
##
/sbin/chkconfig --level 345 avahi-daemon off

##
## disable sshd for LiveCD run
##
if is_liveimg_run ; then
    /sbin/chkconfig --level 2345 sshd off
fi

##
## /etc/inputrc
##
if [ -s /etc/inputrc ] ; then
    sed -i -e 's!#set bell-style none!set bell-style none!;' /etc/inputrc

cat <<"____EOF" >>/etc/inputrc

$if mode=emacs
# for PuTTY
"\eOC": forward-word
"\eOD": backward-word
$endif
____EOF

    /sbin/restorecon /etc/inputrc
fi

##
## /etc/minirc.dfl
##
install -p -m 0644 ${TFILES}/etc/minirc.dfl /etc/minirc.dfl
/sbin/restorecon /etc/minirc.dfl

##
## /etc/profile.d/local*
##
install -p -m 0644 ${TFILES}/etc/profile.d/local* /etc/profile.d/
/sbin/restorecon /etc/profile.d/local*

##
## /etc/sudoers.d/
##
install -p -m 0440 ${TFILES}/etc/sudoers.d/developers /etc/sudoers.d/
/sbin/restorecon /etc/sudoers.d/developers

##
## /etc/yum.repos.d/epel.repo
##
if [ -s /etc/yum.repos.d/epel.repo ] ; then
    sed -i -e '/gpgcheck/a exclude=wine*' /etc/yum.repos.d/epel.repo
    /sbin/restorecon /etc/yum.repos.d/epel.repo
fi

##
## /etc/yum.repos.d/rpmforge.repo
##
if [ -s /etc/yum.repos.d/rpmforge.repo ] ; then
    sed -i -e 's,^\(enabled\s*=\s*\)1,\1''0,g' /etc/yum.repos.d/rpmforge.repo
    sed -i -e '/gpgcheck/a exclude=sqlite*' /etc/yum.repos.d/rpmforge.repo
    /sbin/restorecon /etc/yum.repos.d/rpmforge.repo
fi

##
## /etc/ssh/sshd_config
##
sed -i -e 's,#PermitRootLogin yes,PermitRootLogin no,;s,#UseDNS yes,UseDNS no,;' /etc/ssh/sshd_config
/sbin/restorecon /etc/ssh/sshd_config

##
## /etc/sysctl.d
##
install -d -m 0755 /etc/sysctl.d
install -p -m 0644 ${TFILES}/etc/sysctl.d/ipv4-forward.conf /etc/sysctl.d/ipv4-forward.conf
if ! is_liveimg_run ; then
    install -p -m 0644 ${TFILES}/etc/sysctl.d/vm-swappiness.conf /etc/sysctl.d/vm-swappiness.conf
fi
/sbin/restorecon -r /etc/sysctl.d

##
## /etc/sysconfig/nfs
##
if [ -s /etc/sysconfig/nfs ] ; then
    sed -i -e 's,^\s*#\s*\(RQUOTAD_PORT\|LOCKD_TCPPORT\|LOCKD_UDPPORT\|MOUNTD_PORT\|STATD_PORT\|STATD_OUTGOING_PORT\)=,\1=,' /etc/sysconfig/nfs
    /sbin/restorecon /etc/sysconfig/nfs
fi

##
## /etc/sysconfig/prelink
##
install -p -m 0644 ${TFILES}/etc/sysconfig/prelink /etc/sysconfig/prelink
/sbin/restorecon /etc/sysconfig/prelink

##
## /etc/yum/pluginconf.d/fastestmirror.conf
##
if [ -s /etc/yum/pluginconf.d/fastestmirror.conf ] ; then
    sed -i -e '/^#exclude/a exclude=facebook,uottawa' /etc/yum/pluginconf.d/fastestmirror.conf
    /sbin/restorecon /etc/yum/pluginconf.d/fastestmirror.conf
fi

##
## /etc/pam.d/gdm-password
##
if [ -s /etc/pam.d/gdm-password ] ; then
    sed -i -e '1s/^/auth        required      pam_succeed_if.so user != root quiet\n\n/'    /etc/pam.d/gdm-password
    /sbin/restorecon /etc/pam.d/gdm-password
fi

##
## /etc/vsftpd/vsftpd.conf
##
if [ -s /etc/vsftpd/vsftpd.conf ] ; then

cat <<"____EOF" >>/etc/vsftpd/vsftpd.conf

reverse_lookup_enable=NO
use_localtime=YES
____EOF

    /sbin/restorecon /etc/vsftpd/vsftpd.conf
fi    ## if [ -s /etc/vsftpd/vsftpd.conf ]

## /etc/xdg/autostart/gpk-update-icon.desktop
rm -f /etc/xdg/autostart/gpk-update-icon.desktop

##
## require NetworkManager apply both /etc/sysctl.conf and /etc/sysctl.d/*
## workaround for rhbz #1213118
##
if [ -s /etc/rc.d/init.d/NetworkManager ] ; then
    sed -i -e 's,sysctl [-]e [-]p /etc/sysctl\.conf,apply_sysctl,g' /etc/rc.d/init.d/NetworkManager
    /sbin/restorecon /etc/rc.d/init.d/NetworkManager
fi

##
## add group developers, if missing
## see /etc/sudoers.d/developers above
##
{ /usr/bin/getent group developers >/dev/null ; } || /usr/sbin/groupadd -r developers
