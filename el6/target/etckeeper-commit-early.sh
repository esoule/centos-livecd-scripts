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
/gshadow
/gshadow-
/passwd-
/shadow
/shadow-
/rc.d/rc[0-9].d/[KS][0-9][0-9]firstinst*
/rc.d/rc[0-9].d/[KS][0-9][0-9]livesys*
/selinux/targeted/policy/
/selinux/targeted/modules/active/*.pp
/selinux/targeted/modules/active/commit_num
/selinux/targeted/modules/active/modules/
/selinux/targeted/modules/active/policy.kern
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
