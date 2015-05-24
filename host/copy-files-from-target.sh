#!/bin/bash
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts"

echo "###################################################################"
echo "## running copy-files-from-target.sh"
echo "###################################################################"

if [ -z "${INSTALL_ROOT}" ] ; then
    echo "ERROR: INSTALL_ROOT empty" >&2
    exit 1
fi

/usr/bin/tree -anFp ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}

FROM_TARGET_DIR=${ROOT_CLS_TOP_DIR}/from-target

# Copy files from /etc
( cd ${INSTALL_ROOT} && tar -zcf ${FROM_TARGET_DIR}/etc.tar.gz ./etc )

cp -r --preserve=timestamps ${INSTALL_ROOT}/root ${FROM_TARGET_DIR}/root

/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}

echo "###################################################################"
echo "## DONE running copy-files-from-target.sh"
echo "###################################################################"

exit 0
