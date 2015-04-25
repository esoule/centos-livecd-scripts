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
## disable nginx for both LiveCD and hard drive
##
/sbin/chkconfig nginx off

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
## /etc/sysconfig/iptables, system-config-firewall et al
##
## NOTE: have to do it here, because kickstart firewall
## option is not giving the expected result for LiveCD
## and, also, not all rules can be specified that way
##
install -d -m 0700 /etc/sysconfig/iptables-local
for fn in ipv4-filter-{forward,nfs,ntp} ; do
    install -p -m 0600 ${TFILES}/etc/sysconfig/iptables-local/${fn}    \
        /etc/sysconfig/iptables-local/${fn}
done
/sbin/restorecon -r /etc/sysconfig/iptables-local
for fn in system-config-firewall {ip,ip6}tables{,-config} ; do
    install -p -m 0600 ${TFILES}/etc/sysconfig/${fn}    \
        /etc/sysconfig/${fn}
    /sbin/restorecon /etc/sysconfig/${fn}
done

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

##
## move ftp home directory to /srv/ftp
##
mkdir /srv/ftp /srv/ftp/pub
/sbin/restorecon /srv/ftp /srv/ftp/pub
/usr/sbin/usermod --home=/srv/ftp ftp

##
## move tftp home directory to /srv/tftpboot
##
mkdir /srv/tftpboot
/usr/bin/chcon -u system_u -r object_r -t tftpdir_rw_t /srv/tftpboot
if [ -s /etc/xinetd.d/tftp ] ; then
    sed -i -e 's!/var/lib/tftpboot!/srv/tftpboot!g' /etc/xinetd.d/tftp
    /sbin/restorecon /etc/xinetd.d/tftp
fi

## /etc/xdg/autostart/gpk-update-icon.desktop
rm -f /etc/xdg/autostart/gpk-update-icon.desktop

##
## Store GConf-based admin customizations, part 1
## See https://docs.oracle.com/cd/E36784_01/html/E36853/glmrh.html
## "Customizing GConf Based Optimizations"
##
install -d -m 0755 /etc/gconf/gconf.xml.admin.defaults
GCONFTOOL2_LOAD_ADMIN_DEF='gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.admin.defaults --load'

##
## do not show all valid user accounts in gnome login
## workaround for rhbz #666220
## (see http://blog.toracat.org/2011/01/gnome-login-shows-all-valid-user-accounts-disable-it/ )
##
if ! is_liveimg_run ; then
    ${GCONFTOOL2_LOAD_ADMIN_DEF} /root/centos-livecd-scripts/target/gconfsettings/apps-gdm.xml
fi

##
## Store GConf-based admin customizations, part 2
##
/bin/chmod -R u=rwX,g=rX,o=rX /etc/gconf/gconf.xml.admin.defaults
echo 'xml:readonly:/etc/gconf/gconf.xml.admin.defaults' >/etc/gconf/2/local-defaults.path
/sbin/restorecon /etc/gconf/2/local-defaults.path
/sbin/restorecon -r /etc/gconf/gconf.xml.admin.defaults

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

##
## add user centoslive to groups
##
if is_liveimg_run ; then
    usermod --append --groups developers,dialout,users,uucp,wireshark centoslive
fi
