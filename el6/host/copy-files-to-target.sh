#!/bin/bash
DIST=el6
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts/${DIST}"

echo "###################################################################"
echo "## running copy-files-to-target.sh"
echo "###################################################################"

if [ -z "${INSTALL_ROOT}" ] ; then
    echo "ERROR: INSTALL_ROOT empty" >&2
    exit 1
fi

/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}

rm -rf ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}
mkdir -p ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}
mkdir ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}/from-target
touch ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}/from-target/.exists
rm -rf ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}/target
cp -r --preserve=mode,timestamps ${ROOT_CLS_TOP_DIR}/target ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}/target

/usr/bin/tree -anFp ${INSTALL_ROOT}${ROOT_CLS_TOP_DIR}

echo "###################################################################"
echo "## DONE running copy-files-to-target.sh"
echo "###################################################################"

exit 0
