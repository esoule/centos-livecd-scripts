
repo --name=esrepo-main    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/main/packages/centos/6/x86_64/

repo --name=esrepo-extras-livesys    --baseurl=http://centos.mirror.local/ftp/pub/linux/esrepo/extras/packages/centos/6/x86_64/    --include=firstinst-*,livesys-service
