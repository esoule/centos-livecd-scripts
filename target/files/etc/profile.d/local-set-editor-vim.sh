## specify vim as default editor for all users on this system
if [ -z "${EDITOR}" ] ; then
    if [ -x /usr/bin/vim ] ; then
        export EDITOR=/usr/bin/vim
    fi
fi


