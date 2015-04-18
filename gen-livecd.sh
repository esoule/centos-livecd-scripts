#!/bin/bash
PROGNAME=$(echo `basename $0`)
TOP_DIR=$(cd `dirname $0` && pwd)

show_usage_and_exit()
{
    echo "Usage: $PROGNAME KICKSTART_FILE" >&2
    exit 1
}

e()
{
    echo "ERROR: ""$@" >&2
}

KS=$1

if [ -z "$KS" ] ; then
    e "kickstart file is required"
    show_usage_and_exit
fi
if [ ! \( -f "$KS" -a -r "$KS" \) ] ; then
    e "kickstart file must be a readable regular file ($KS)"
    show_usage_and_exit
fi
KSR=`realpath --strip "$KS"`
if [ ! \( -n "$KSR" -a -f "$KSR" -a -r "$KSR" \) ] ; then
    e "kickstart file must be a readable regular file ($KSR)"
    show_usage_and_exit
fi
if [ "$EUID" -ne 0 ] ; then
    e "please run the script as root"
    show_usage_and_exit
fi

set -x

rm -rf /root/centos-livecd-scripts
mkdir /root/centos-livecd-scripts
mkdir /root/centos-livecd-scripts/from-host
touch /root/centos-livecd-scripts/from-host/.exists
mkdir /root/centos-livecd-scripts/from-target
touch /root/centos-livecd-scripts/from-target/.exists

cp -r --preserve=mode,timestamps    \
    --target-directory /root/centos-livecd-scripts    \
    $TOP_DIR/host $TOP_DIR/target

/usr/bin/tree -anFp /root/centos-livecd-scripts

d=$PWD
mkdir -p $d/out $d/out/v $d/out/v/cache $d/out/v/tmp
ls -lad $d/out $d/out/v $d/out/v/cache $d/out/v/tmp

( cd out && livecd-creator -c "$KSR" --tmpdir=$d/out/v/tmp --cache=$d/out/v/cache )

rm -rf $d/out/from-host
rm -rf $d/out/from-target
cp -r --preserve=timestamps  /root/centos-livecd-scripts/from-host  $d/out/from-host
cp -r --preserve=timestamps  /root/centos-livecd-scripts/from-target  $d/out/from-target

for dn in $d/out/from-host $d/out/from-target ; do
    find $dn -type d -exec chmod 0775 {} \;
    find $dn -type f -exec chmod 0664 {} \;
    find $dn -type d -exec chgrp users {} \;
    find $dn -type f -exec chgrp users {} \;
done

/usr/bin/tree -anFp $d/out/from-host
/usr/bin/tree -anFp $d/out/from-target
