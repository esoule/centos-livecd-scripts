## specify less as default pager for all users on this system
if [ -z "${PAGER}" ] ; then
    if [ -x /usr/bin/less ] ; then
        export PAGER=less
    fi
fi

