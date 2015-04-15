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

d=$PWD
mkdir -p $d/out $d/out/v $d/out/v/cache $d/out/v/tmp
ls -lad $d/out $d/out/v $d/out/v/cache $d/out/v/tmp

( cd out && livecd-creator -c "$KSR" --tmpdir=$d/out/v/tmp --cache=$d/out/v/cache )

