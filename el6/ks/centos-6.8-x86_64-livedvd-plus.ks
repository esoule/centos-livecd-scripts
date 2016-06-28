
part / --size 5600 --fstype ext3

########################################################################
# Include kickstart files
########################################################################

%include centos-6.8-all-live-base.ks
%include centos-6.8-repos-common-x86_64.ks
%include centos-6.8-repos-esrepo-main-x86_64.ks
%include centos-6.8-repos-esrepo-extras-x86_64.ks
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
