########################################################################
#
# centos-6.8-all-live-base.ks
#
# Defines the basics for all kickstarts of centos-6.8-*-live
# Kickstarts including this template can override these settings
#
########################################################################

lang en_CA.UTF-8
keyboard us
timezone  America/Toronto
auth  --useshadow  --passalgo=sha512
selinux --enforcing
firewall --enabled --ssh

xconfig --startxonboot
services --enabled=NetworkManager,sshd --disabled=network

########################################################################
# Packages
########################################################################

%packages
kernel

%end

%post --nochroot
DIST=el6
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts/${DIST}"
echo "###################################################################"
echo "## running ${ROOT_CLS_TOP_DIR}/host/copy-files-to-target.sh"
echo "###################################################################"
set -x
/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}
/bin/bash -x ${ROOT_CLS_TOP_DIR}/host/copy-files-to-target.sh 2>&1 | tee ${ROOT_CLS_TOP_DIR}/from-host/copy-files-to-target.log
%end

%post
DIST=el6
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts/${DIST}"
echo "###################################################################"
echo "## running ${ROOT_CLS_TOP_DIR}/target/post-install.sh"
echo "###################################################################"
set -x
/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}
/bin/bash -x ${ROOT_CLS_TOP_DIR}/target/post-install.sh 2>&1 | tee ${ROOT_CLS_TOP_DIR}/from-target/post-install.log
%end

%post --nochroot
DIST=el6
ROOT_CLS_TOP_DIR="/root/centos-livecd-scripts/${DIST}"
echo "###################################################################"
echo "## running ${ROOT_CLS_TOP_DIR}/host/postnochroot-install.sh"
echo "###################################################################"
set -x
/usr/bin/tree -anFp ${ROOT_CLS_TOP_DIR}
/bin/bash -x ${ROOT_CLS_TOP_DIR}/host/postnochroot-install.sh 2>&1 | tee ${ROOT_CLS_TOP_DIR}/from-host/postnochroot-install.log
/bin/bash -x ${ROOT_CLS_TOP_DIR}/host/copy-files-from-target.sh 2>&1 | tee ${ROOT_CLS_TOP_DIR}/from-host/copy-files-from-target.log
%end
