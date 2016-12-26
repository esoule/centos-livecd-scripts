########################################################################
# Packages
########################################################################

%packages
kernel
@base
@core
@basic-desktop
@debugging
@desktop-debugging
@desktop-platform
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
alacarte
avahi
brasero
certmonger
crypto-utils
diffstat
dos2unix
dtach
dump
gpm
ebtables
emacs-git
expect
freetype
freetype-devel
ftp
gconf-editor
git
git-cvs
git-email
git-gui
git-svn
gitk
hardlink
httpd-tools
hunspell-fr
hunspell-he
hunspell-ru
iotop
java-1.6.0-openjdk
java-1.7.0-openjdk
java-1.8.0-openjdk
jwhois
k3b
kcoloredit
kdeaccessibility
kdeadmin
kdeartwork-screensavers
kdebase
kdegraphics
kdenetwork
kdeplasma-addons
kdesdk
kdesdk-utils
kdeutils
kde-settings-pulseaudio
kernel-devel
kabi-yum-plugins
krb5-workstation
lftp
mc
minicom
nc
nmap
oddjob
openldap-clients
pam_krb5
pax
perf
perl-Git
perl-TermReadKey
php-cli
pidgin
pinentry-gtk
pinentry-qt
powertop
recode
samba
samba-winbind
screen
scrub
sdparm
setroubleshoot
setroubleshoot-plugins
setroubleshoot-server
stunnel
system-config-language
telnet
tftp
tftp-server
tree
unix2dos
vorbis-tools
vsftpd
wireshark
wireshark-gnome
xsettings-kde
xterm
yum-plugin-changelog
yum-plugin-versionlock
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
cppunit
epel-release
etckeeper
fuse-sshfs
htop
iperf
kdiff3
libjoedog
meld
ncdu
ncftp
p7zip
p7zip-plugins
perl-Sort-Naturally
putty
rsnapshot
qgit
siege
tinyxml

#### Bits from elrepo repository
elrepo-release
kmod-e1000
kmod-e1000e
kmod-r8168
kmod-r8169

#### Bits from nginx repository
nginx-release-centos
nginx

#### Bits from esrepo-main repository (was rpmforge)
fuse-iso
lha
numlockx
realpath
unrar
wput

#### Bits from esrepo-main repository
discount
cppunit113
cppunit113-demos
fsarchiver
krusader
os-tweaks-aliases
os-tweaks-bash-prompt
os-tweaks-editor-vim
os-tweaks-grep-color
os-tweaks-ls-color-extra
os-tweaks-pager-less
os-tweaks-sudo-developers
os-tweaks-sysctl-ipv4-forward
os-tweaks-sysctl-vm-swappiness
ttt

#### Bits from esrepo-livemedia repository
firstinst-adduser-linuxuser
firstinst-adduser-tempuser1
firstinst-anaconda-liveinst-utc-timezone
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
firstinst-gconf-nautilus-no-autorun
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
