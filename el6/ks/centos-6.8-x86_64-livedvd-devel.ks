# System language
lang en_CA.UTF-8
# System keyboard
keyboard us
# System timezone
timezone  America/Toronto
# System authorization information
auth  --useshadow  --passalgo=sha512
selinux --enforcing
# Firewall configuration
firewall --enabled --ssh
repo --name=base    --baseurl=http://centos.mirror.local/ftp/pub/linux/centos/6/os/x86_64/    --exclude=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=extras     --mirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=extras     --exclude=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=updates    --mirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=updates    --exclude=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=epel    --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64
repo --name=esrepo-main    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/main/packages/centos/6/x86_64/    --include=coan,fsarchiver,k4dirstat,krusader,mtd-utils,mtd-utils-ubi,os-tweaks*,unifdef
repo --name=esrepo-extras    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/extras/packages/centos/6/x86_64/    --include=firstinst-*,freetype*,livesys-service,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=nginx-noarch    --baseurl=http://nginx.org/packages/centos/6/noarch/    --include=nginx-release-centos
repo --name=nginx    --baseurl=http://nginx.org/packages/centos/6/x86_64/    --include=nginx
repo --name=elrepo    --baseurl=http://elrepo.org/linux/elrepo/el6/x86_64/    --include=elrepo-release,kmod-e1000,kmod-e1000e,kmod-r8168,kmod-r8169
repo --name=rpmforge    --baseurl=http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/    --include=fuse-cryptofs,fuse-iso,lha,numlockx,realpath,rpmforge-release,synergy,unrar,wput
xconfig --startxonboot
# Partition information - for LiveCD and installing to hard drive
part / --size 7200 --fstype ext3
services --enabled=NetworkManager,sshd --disabled=network


%packages
kernel
@base
@core
@basic-desktop
@debugging
@desktop-debugging
@desktop-platform
@development
@directory-client
@fonts
@graphical-admin-tools
@input-methods
@internet-browser
@legacy-x
@network-file-system-client
@office-suite
@print-client
@remote-desktop-clients
@server-platform
@server-policy
@technical-writing
@workstation-policy
sgpio
device-mapper-persistent-data
libXmu
@x11
mtools
python-dmidecode
sgpio
genisoimage
wodim
libXmu
-kdm
-prelink
vino
gthumb
-totem
-totem-mozplugin
-totem-nautilus
thunderbird
rdesktop
tigervnc
tigervnc-server
tsclient
vinagre
#added because @general-desktop is gone
gedit
gedit-plugins
gnome-backgrounds
evince
evince-dvi
file-roller
gcalctool
gnome-disk-utility
gnome-power-manager
gnome-system-monitor
gnome-utils
#added from base repo, for custom LiveDVD
NetworkManager-gnome
abrt-gui
asciidoc
alacarte
avahi
boost
boost-date-time
boost-filesystem
boost-graph
boost-iostreams
boost-math
boost-program-options
boost-python
boost-regex
boost-serialization
boost-signals
boost-system
boost-test
boost-thread
boost-wave
brasero
cdparanoia
certmonger
check
check-devel
cmake
crypto-utils
dia
diffstat
docbook-utils
docbook-utils-pdf
dos2unix
dtach
dump
emacs
glibc-devel.i686
glibc-devel.x86_64
gnuplot44
gnuplot44-doc
graphviz
graphviz-gd
gpm
ebtables
emacs-git
expect
freetype.i686
freetype.x86_64
freetype-devel
ftp
gconf-editor
gimp
gimp-data-extras
gimp-help
gimp-help-browser
git
git-cvs
git-email
git-gui
git-p4
git-svn
gitk
hardlink
httpd-tools
hunspell-fr
hunspell-he
hunspell-ru
ImageMagick
imake
iotop
java-1.6.0-openjdk
jwhois
k3b
kcoloredit
kdeaccessibility
kdeadmin
kdeartwork-screensavers
kdebase
kdegraphics
kdemultimedia
kdenetwork
kdeplasma-addons
kdesdk
kdesdk-utils
kdesvn
kdeutils
kde-settings-pulseaudio
kernel-devel
kabi-yum-plugins
kiconedit
kipi-plugins
kmid
konq-plugins
krb5-workstation
ksig
ksshaskpass
lftp
logwatch
lz4
lzop
mc
minicom
mutt
nc
ncurses-devel
ncurses-term
net-snmp-devel
net-snmp-utils
net-snmp-perl
nmap
oddjob
odt2txt
openldap-clients
oprofile
pam_krb5
pax
perf
perl-Git
perl-TermReadKey
php
php-adodb
php-cli
php-mbstring
php-mcrypt
php-mysql
php-pdo
pidgin
pinentry-gtk
pinentry-qt
powertop
python-docutils
recode
rpmdevtools
rpmlint
samba
samba-winbind
screen
scrub
sdparm
seahorse
seahorse-plugins
setools-console
setroubleshoot
setroubleshoot-doc
setroubleshoot-plugins
setroubleshoot-server
sox
star
stunnel
system-config-language
tbb
tbb-devel
telnet
texinfo
tftp
tftp-server
tree
unix2dos
vorbis-tools
vsftpd
wireshark
wireshark-gnome
xmlto-tex
xmltoman
xsettings-kde
xterm
yum-plugin-changelog
yum-plugin-downloadonly
yum-plugin-tmprepo
yum-plugin-verify
yum-plugin-versionlock
yum-presto
yum-utils
-akonadi
-kdepim
-kdepim-runtime-libs
-kdepim-runtime
-kdepimlibs-akonadi
# Fonts
cjkuni-fonts-ghostscript
cjkuni-ukai-fonts
culmus-aharoni-clm-fonts
culmus-caladings-clm-fonts
culmus-david-clm-fonts
culmus-drugulin-clm-fonts
culmus-ellinia-clm-fonts
culmus-frank-ruehl-clm-fonts
culmus-miriam-clm-fonts
culmus-miriam-mono-clm-fonts
culmus-nachlieli-clm-fonts
culmus-yehuda-clm-fonts
ipa-gothic-fonts
ipa-mincho-fonts
ipa-pgothic-fonts
ipa-pmincho-fonts
kacst-art-fonts
kacst-book-fonts
kacst-decorative-fonts
kacst-digital-fonts
kacst-farsi-fonts
kacst-letter-fonts
kacst-naskh-fonts
kacst-office-fonts
kacst-one-fonts
kacst-pen-fonts
kacst-poster-fonts
kacst-qurn-fonts
kacst-screen-fonts
kacst-title-fonts
kacst-titlel-fonts
un-core-batang-fonts
un-core-dinaru-fonts
un-core-graphic-fonts
un-core-gungseo-fonts
un-core-pilgi-fonts
vlgothic-p-fonts
#### Bits from epel repository (except livecd-tools, python-imgcreate)
bash-completion
Canna-libs
ccache
compface
createrepo_c
createrepo_c-libs
ddd
epel-release
etckeeper
fuse-sshfs
htop
iperf
kdiff3
libjoedog
meld
mock
ncdu
ncftp
neXtaw
nut
nut-cgi
nut-client
p7zip
p7zip-plugins
perl-Sort-Naturally
pigz
putty
pyliblzma
rsnapshot
qgit
siege
thttpd
uboot-tools
xemacs
xemacs-common
xemacs-filesystem
xemacs-packages-base
#### Bits from elrepo repository
elrepo-release
kmod-e1000
kmod-e1000e
kmod-r8168
kmod-r8169
#### Bits from nginx repository
nginx-release-centos
nginx
#### Bits from rpmforge
fuse-cryptofs
fuse-iso
lha
numlockx
realpath
rpmforge-release
synergy
unrar
wput
#### Bits from esrepo-main repository
coan
fsarchiver
k4dirstat
krusader
mtd-utils
mtd-utils-ubi
os-tweaks-aliases
os-tweaks-bash-prompt
os-tweaks-editor-vim
os-tweaks-grep-color
os-tweaks-ls-color-extra
os-tweaks-pager-less
os-tweaks-sudo-developers
os-tweaks-sysctl-ipv4-forward
os-tweaks-sysctl-vm-swappiness
unifdef
#### Bits from esrepo-extras repository
firstinst-adduser-linuxuser
firstinst-adduser-tempuser1
firstinst-avahi-daemon-off
firstinst-core
firstinst-developers-developers
firstinst-etckeeper-commit
firstinst-firewall-config
firstinst-firstinst-services-off
firstinst-fstab-noatime
firstinst-gconf-clock-panel-applet-location-Montreal
firstinst-gconf-clock-panel-applet-prefs
firstinst-gconf-custom
firstinst-gconf-file-browser-prefs
firstinst-gconf-font-rendering-config
firstinst-gconf-gpk-update-icon-off
firstinst-gconf-login-user-list-off
firstinst-gconf-metacity-num-workspaces
firstinst-gconf-screensaver-lock-off
firstinst-gconf-session-idle-delay
firstinst-gconf-terminal-default-profile-prefs
firstinst-gconf-terminal-global-prefs
firstinst-gdm-disable-root-login
firstinst-git-lola-config
firstinst-gpk-update-icon-off
firstinst-grub-config
firstinst-inputrc-config
firstinst-minicom-ttyS0-config
firstinst-NetworkManager-sysctl-fixup
firstinst-nfs-config
firstinst-nginx-off
firstinst-prelink-off
firstinst-root-gitconfig
firstinst-sshd-config
firstinst-tftp-config
firstinst-vsftpd-config
firstinst-yum-config
firstinst-yum-epel-repo-config
firstinst-yum-rpmforge-repo-config
livesys-service
# livecd bits to set up the livecd and be able to install
memtest86+
python-imgcreate
livecd-tools
anaconda
device-mapper-multipath
isomd5sum
syslinux

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

