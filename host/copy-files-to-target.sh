#!/bin/bash
echo "###################################################################"
echo "## running copy-files-to-target.sh"
echo "###################################################################"

if [ -z "${INSTALL_ROOT}" ] ; then
    echo "ERROR: INSTALL_ROOT empty" >&2
    exit 1
fi

/usr/bin/tree -anFp /root/centos-livecd-scripts

rm -rf ${INSTALL_ROOT}/root/centos-livecd-scripts
mkdir ${INSTALL_ROOT}/root/centos-livecd-scripts
mkdir ${INSTALL_ROOT}/root/centos-livecd-scripts/from-target
touch ${INSTALL_ROOT}/root/centos-livecd-scripts/from-target/.exists
rm -rf ${INSTALL_ROOT}/root/centos-livecd-scripts/target
cp -r --preserve=mode,timestamps /root/centos-livecd-scripts/target ${INSTALL_ROOT}/root/centos-livecd-scripts/target

/usr/bin/tree -anFp ${INSTALL_ROOT}/root/centos-livecd-scripts

echo "###################################################################"
echo "## DONE running copy-files-to-target.sh"
echo "###################################################################"

exit 0
