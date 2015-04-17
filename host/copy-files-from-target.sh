#!/bin/bash
echo "###################################################################"
echo "## running copy-files-from-target.sh"
echo "###################################################################"

if [ -z "${INSTALL_ROOT}" ] ; then
    echo "ERROR: INSTALL_ROOT empty" >&2
    exit 1
fi

/usr/bin/tree -anFp ${INSTALL_ROOT}/root/centos-livecd-scripts

FROM_TARGET_DIR=/root/centos-livecd-scripts/from-target

# Copy files from /etc
( cd ${INSTALL_ROOT} && tar -zcf ${FROM_TARGET_DIR}/etc.tar.gz ./etc )

cp -r --preserve=timestamps ${INSTALL_ROOT}/root ${FROM_TARGET_DIR}/root

/usr/bin/tree -anFp /root/centos-livecd-scripts

echo "###################################################################"
echo "## DONE running copy-files-from-target.sh"
echo "###################################################################"

exit 0
