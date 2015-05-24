#!/bin/bash
PROGNAME=$(echo `basename $0`)
TOP_DIR=$(cd `dirname $0` && pwd)
ERR=0
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts"

show_usage_and_exit()
{
cat <<__USAGE_DOC__
Usage: $PROGNAME KICKSTART_FILE

Generate a LiveDVD using KICKSTART_FILE and scripts found inside "host"
and "target" subdirectories of centos-livecd-scripts

Kickstart files compatible with $PROGNAME are found in "ks" subdirectory
of centos-livecd-scripts

Dependencies for $PROGNAME:

  * realpath
  * livecd-creator from livecd-tools
  * $PROGNAME must be run as root

Example for running $PROGNAME out of tree using sudo:

    sudo ../centos-livecd-scripts/gen-livecd.sh    \\
        ../centos-livecd-scripts/ks/centos6-liveDVD-desktop.cfg

__USAGE_DOC__
    exit 1
}

e()
{
    echo "ERROR: ""$@" >&2
    ERR=1
}

check_kickstart_file()
{
    #"Kickstart file must be provided"
    if [ -z "$KS" ] ; then
        e "Kickstart file must be provided"
        return 0
    fi
    if [ ! \( -f "$KS" -a -r "$KS" \) ] ; then
        e "Kickstart file must be provided (check path $KS)"
        return 0
    fi
    KSR=`realpath --strip "$KS"`
    if [ ! \( -n "$KSR" -a -f "$KSR" -a -r "$KSR" \) ] ; then
        e "kickstart file must be a readable regular file ($KSR)"
        return 0
    fi
    KSBN=`basename ${KSR}`
    KSDIR=${KSBN%.cfg}
    KSDIR=${KSDIR%.ks}
    if [ -z "$KSDIR" ] ; then
        e "could not figure out KSDIR from KSBN=${KSBN}"
        return 0
    fi
    return 0
}

check_prerequisite()
{
    local exename="$1"
    local packagename="$2"
    local reponame="$3"
    local fullpath=$(type -p ${exename})
    if [ -n "${fullpath}" -a -x "${fullpath}" ] ; then
        return 0
    fi
    e "Executable ${exename} not found"
    e "    please install package ${packagename}"
    e "    (from repository ${reponame})"
    return 0
}

check_root_for_creator()
{
    if [ "$EUID" -ne 0 ] ; then
        e "please run $PROGNAME as root"
        e "    (livecd-creator program requires root to run)"
    fi
    return 0
}

KS="$1"
ERR=0
check_kickstart_file
check_prerequisite realpath "realpath" "rpmforge"
check_prerequisite livecd-creator "livecd-tools" "epel"
check_root_for_creator
if [ $ERR -ne 0 ] ; then
    e "one or more errors occurred, stopping"
    echo "" >&2
    show_usage_and_exit >&2
fi

set -x

rm -rf ${ROOT_CLS_TOP_DIR}
mkdir -p ${ROOT_CLS_TOP_DIR}
mkdir ${ROOT_CLS_TOP_DIR}/from-host   ${ROOT_CLS_TOP_DIR}/from-target
touch ${ROOT_CLS_TOP_DIR}/from-host/.exists
touch ${ROOT_CLS_TOP_DIR}/from-target/.exists

cp -r --preserve=mode,timestamps    \
    --target-directory ${ROOT_CLS_TOP_DIR}    \
    $TOP_DIR/host $TOP_DIR/target

/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}

d=$PWD
result_dir=$d/out/${KSDIR}
mkdir -p $d/out $d/out/v $d/out/v/cache $d/out/v/tmp ${result_dir}
chmod 0775 $d/out $d/out/v $d/out/v/cache $d/out/v/tmp ${result_dir}
chgrp users $d/out $d/out/v $d/out/v/cache $d/out/v/tmp ${result_dir}
ls -lad $d/out $d/out/v $d/out/v/cache $d/out/v/tmp ${result_dir}

( cd ${result_dir} && livecd-creator -c "$KSR" --releasever=6 --tmpdir=$d/out/v/tmp --cache=$d/out/v/cache )

rm -rf ${result_dir}/from-host
rm -rf ${result_dir}/from-target
cp -r --preserve=timestamps  ${ROOT_CLS_TOP_DIR}/from-host  ${result_dir}/from-host
cp -r --preserve=timestamps  ${ROOT_CLS_TOP_DIR}/from-target  ${result_dir}/from-target

for dn in ${result_dir}/from-host ${result_dir}/from-target ; do
    find $dn -type d -exec chmod 0775 {} \;
    find $dn -type f -exec chmod 0664 {} \;
    find $dn -type d -exec chgrp users {} \;
    find $dn -type f -exec chgrp users {} \;
done

/usr/bin/tree -anFp ${result_dir}/from-host
/usr/bin/tree -anFp ${result_dir}/from-target
