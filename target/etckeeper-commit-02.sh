#!/bin/bash
if [ ! -x /usr/bin/etckeeper ] ; then
    exit 0
fi

# workaround for "fatal: $HOME is not set"
if [ -z "$HOME" ] ; then
    export HOME=/root
fi

cat <<"____EOF" >/etc/.gitignore
# begin section inserted by centos-livecd-scripts
/group-
/gshadow-
/passwd-
/shadow
/shadow-
yum.repos.d/tmp-*.repo
*.bak

# end section inserted by centos-livecd-scripts
#

____EOF
/sbin/restorecon /etc/.gitignore

/usr/bin/etckeeper init    >/dev/null

/usr/bin/etckeeper commit "Initial commit"    >/dev/null

/usr/bin/etckeeper vcs gc    >/dev/null

exit 0
