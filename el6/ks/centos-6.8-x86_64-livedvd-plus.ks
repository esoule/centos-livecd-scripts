
repo --name=esrepo-main    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/main/packages/centos/6/x86_64/    --include=coan,fsarchiver,k4dirstat,krusader,mtd-utils,mtd-utils-ubi,os-tweaks*,unifdef
repo --name=esrepo-extras    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/extras/packages/centos/6/x86_64/    --include=firstinst-*,freetype*,livesys-service,minicom,wireshark*,emacs-git,git,git-core*,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*

part / --size 5600 --fstype ext3

########################################################################
# Include kickstart files
########################################################################

%include centos-6.8-all-live-base.ks
%include centos-6.8-repos-common-x86_64.ks
%include centos-6.8-packages-desktop-allarch.ks
%include centos-6.8-packages-plus-allarch.ks

########################################################################
# Packages
########################################################################

%packages
freetype.i686
freetype.x86_64
freetype-devel.i686
freetype-devel.x86_64

%end
