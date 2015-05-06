CentOS 6 LiveCD Scripts
=======================

This CentOS 6 LiveCD script set generates LiveCD images from kickstart
files found in ks directory.

Synopsis
--------

1. Populate a local mirror and point centos.mirror.local to your
   server's address in /etc/hosts; or change the mirror URL inside the
   kickstart file you want to use (see Mirrors below)

2. Run the script using sudo or as root, out of tree

        sudo ../centos-livecd-scripts/gen-livecd.sh    \
             ../centos-livecd-scripts/ks/centos6-liveDVD-desktop.cfg

Requirements
------------

* realpath (available in rpmforge repository)
* livecd-creator from livecd-tools (available in epel repository)
* gen-livecd.sh must be run as root

Changes from original kickstart files
-------------------------------------

Kickstart files found in ks directory are derived from original
centos6-liveDVD-desktop.cfg from [LiveCD-DVD](http://people.centos.org/arrfab/CentOS6/LiveCD-DVD/).

Notable changes:

* double and triple escaped files found inside the original
  centos6-liveDVD-desktop.cfg have been extracted to separate
  files
* additional install tasks are executed at both LiveCD run and first run
  after install
* changes to configuration files in /etc are recorded by etckeeper into
  a local git repository
* list of installed packages is placed into the root directory of the
  completed LiveCD

Mirrors
-------

Kickstart files found in ks subdirectory refer to the URL
http://centos.mirror.local/ftp/pub/linux/centos/\$releasever/os/\$basearch/.

For latest CentOS 6.x x86_64, the URL translates to
http://centos.mirror.local/ftp/pub/linux/centos/6/os/x86_64/

One way to use this URL is to populate a local mirror using DVD images found on
[mirror.centos.org](http://mirror.centos.org/centos/6/isos/x86_64/)
and specify your web server's IP address for centos.mirror.local
name

        10.11.12.13    centos.mirror.local

Another way is to change the URL inside the kickstart file
to the nearest mirror found in [mirrorlist](http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=os).

Modifying kickstart files
-------------------------

Refer to [Creating the Kickstart File](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-file.html)
and following pages of Red Hat Enterprise Linux 6 Installation Guide for
more information on kickstart file syntax.

