#!/bin/bash

source /root/centos-livecd-scripts/target/livesys-inst-functions

TFILES=/root/centos-livecd-scripts/target/files

##
## Remove all livesys* services
##
LIVESYS_SERVICES='livesys livesys-inst-early livesys-inst-late livesys-late'
for svc_name in ${LIVESYS_SERVICES} ; do
    /sbin/chkconfig ${svc_name} off
    /sbin/chkconfig --del ${svc_name}
    rm -f /etc/rc.d/init.d/${svc_name}
done
svc_name=livesys-inst-cleanup
/sbin/chkconfig ${svc_name} off
/sbin/chkconfig --del ${svc_name}

##
## record final state of /etc
##
/bin/bash -x /root/centos-livecd-scripts/target/etckeeper-commit-late.sh
