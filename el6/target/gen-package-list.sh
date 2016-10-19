#!/bin/bash

DESTDIR="$1"
if [ -z "$DESTDIR" ] ; then
	DESTDIR="$PWD"
fi

/bin/rpm -q --all --queryformat '%{NAME}\t%{ARCH}\n'    \
	| LANG=en_CA.UTF-8 sort -t $'\t' --key=1,1 --key=2,2    \
	> ${DESTDIR}/centos-installed-packages-summary.txt
/bin/rpm -q --all --queryformat '%{NAME}\t%{ARCH}\t%{VERSION}-%{RELEASE}\t%{SIZE}\t%{VENDOR}\n'    \
	| LANG=en_CA.UTF-8 sort -t $'\t' --key=5,5 --key=1,1 --key=2,2    \
	> ${DESTDIR}/centos-installed-packages-detail.txt

