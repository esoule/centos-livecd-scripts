
repo --name=esrepo-main    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/main/packages/centos/6/x86_64/    --include=coan,fsarchiver,k4dirstat,krusader,mtd-utils,mtd-utils-ubi,os-tweaks*,unifdef
repo --name=esrepo-extras    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/extras/packages/centos/6/x86_64/    --include=firstinst-*,freetype*,livesys-service,minicom,wireshark*,emacs-git,git,git-core*,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*

part / --size 7200 --fstype ext3

########################################################################
# Include kickstart files
########################################################################

%include centos-6.8-all-live-base.ks
%include centos-6.8-x86_64-repos.ks
%include centos-6.8-all-live-desktop-packages.ks
%include centos-6.8-all-live-plus-packages.ks
%include centos-6.8-all-live-devel-packages.ks

########################################################################
# Packages
########################################################################

%packages
freetype.i686
freetype.x86_64
freetype-devel.i686
freetype-devel.x86_64
glibc-devel.i686
glibc-devel.x86_64

%end
