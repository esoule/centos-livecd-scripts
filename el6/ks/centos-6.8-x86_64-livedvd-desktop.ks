
repo --name=C6.8-base    --baseurl=http://centos.mirror.local/ftp/pub/linux/centos/6/os/x86_64/    --include=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=esrepo-main    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/main/packages/centos/6/x86_64/    --include=fsarchiver,os-tweaks*
repo --name=esrepo-extras    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/extras/packages/centos/6/x86_64/    --include=firstinst-*,livesys-service

part / --size 5600 --fstype ext3

########################################################################
# Include kickstart files
########################################################################

%include centos-6.8-all-live-base.ks
%include centos-6.8-x86_64-repos.ks
%include centos-6.8-all-live-desktop-packages.ks

########################################################################
# Packages
########################################################################

%packages
freetype.i686
freetype.x86_64
freetype-devel.i686
freetype-devel.x86_64

%end
