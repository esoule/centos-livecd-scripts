
repo --name=C6.8-base    --baseurl=http://centos.mirror.local/ftp/pub/linux/centos/6/os/i386/    --include=freetype*,minicom,wireshark*,emacs-git,git,git-core*,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*

part / --size 5600 --fstype ext4

########################################################################
# Include kickstart files
########################################################################

%include centos-6.9-all-live-base.ks
%include centos-6.9-repos-common-i386.ks
%include centos-6.9-repos-esrepo-main-i386.ks
%include centos-6.9-packages-desktop-allarch.ks
%include centos-6.9-packages-desktop-i386.ks

########################################################################
# Packages
########################################################################

%packages

%end
