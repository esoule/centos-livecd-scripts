
part / --size 5600 --fstype ext4

########################################################################
# Include kickstart files
########################################################################

%include centos-6.8-all-live-base.ks
%include centos-6.8-repos-common-x86_64.ks
%include centos-6.8-repos-esrepo-main-x86_64.ks
%include centos-6.8-repos-esrepo-extras-x86_64.ks
%include centos-6.8-packages-desktop-allarch.ks
%include centos-6.8-packages-desktop-x86_64.ks
%include centos-6.8-packages-desktop-i386.ks
%include centos-6.8-packages-plus-allarch.ks
%include centos-6.8-packages-plus-x86_64.ks
%include centos-6.8-packages-plus-i386.ks

########################################################################
# Packages
########################################################################

%packages

%end
