#!/bin/bash

source /root/centos-livecd-scripts/target/livesys-inst-functions

TFILES=/root/centos-livecd-scripts/target/files

##
## record final state of /etc
##
/bin/bash -x /root/centos-livecd-scripts/target/etckeeper-commit-98.sh
