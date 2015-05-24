#!/bin/bash
DIST=el6
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts/${DIST}"

FTDIR=${ROOT_CLS_TOP_DIR}/from-target

# Copy licensing information
cp $INSTALL_ROOT/usr/share/doc/centos-release-*/GPL $LIVE_ROOT/GPL

# Copy installed package list
cp ${INSTALL_ROOT}${FTDIR}/centos-installed-packages*.txt $LIVE_ROOT/

# add livecd-iso-to-disk utility on the LiveCD
# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi

/bin/bash -x ${ROOT_CLS_TOP_DIR}/host/edit-isolinux-cfg.sh

