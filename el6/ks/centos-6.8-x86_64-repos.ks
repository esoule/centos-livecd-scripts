
repo --name=base    --baseurl=http://centos.mirror.local/ftp/pub/linux/centos/6/os/x86_64/    --exclude=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=extras     --mirrorlist=http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=extras     --exclude=freetype*,minicom,wireshark*,emacs-git,git,git-cvs,git-email,git-gui,git-p4,git-svn,gitk,perl-Git*
repo --name=epel    --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64
repo --name=nginx-noarch    --baseurl=http://nginx.org/packages/centos/6/noarch/    --include=nginx-release-centos
repo --name=nginx    --baseurl=http://nginx.org/packages/centos/6/x86_64/    --include=nginx
repo --name=elrepo    --baseurl=http://elrepo.org/linux/elrepo/el6/x86_64/    --include=elrepo-release,kmod-e1000,kmod-e1000e,kmod-r8168,kmod-r8169
repo --name=rpmforge    --baseurl=http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/    --include=fuse-cryptofs,fuse-iso,lha,numlockx,realpath,rpmforge-release,synergy,unrar,wput