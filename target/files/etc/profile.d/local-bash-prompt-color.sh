# color bash prompt, different color for different users
# local file, not part of any CentOS packages

# for interactive shells only
if [ -n "${PS1}" ] ; then

    # use '[user@host /full/path]$ ' for normal users
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \w]\\$ "
    # use '[user@host /full/path]$ ' for root as well
    [ "$PS1" = "[\u@\h \W]\\$ " ] && PS1="[\u@\h \w]\\$ "

    # trim full path in \W to 3 elements
    if [ -z "${PROMPT_DIRTRIM}" ] ; then
        PROMPT_DIRTRIM=3
    fi

    # colour the user@host in blue (normal user) or red (root)
    # colour the /full/path in green
    # if root session is run using "su" and not "su -",
    # print a note "(env from ${USER})" with username of
    # the user who started the session
    if [ -z "${LOCAL_BASH_PROMPT_ORIG_PS1}" ] ; then
        if [ "${PS1}" = "[\u@\h \w]\\$ " ] ; then
            LOCAL_BASH_PROMPT_ORIG_PS1=${PS1}
    
            if [ "${EUID:-}" != 0 ] ; then
                PS1="[\[\033[34m\]\u@\h\[\033[0m\] \[\033[32m\]\w\[\033[0m\]]\\$ "
            else
                if [ "${LOGNAME}" = "root" ] ; then
                    PS1="[\[\033[1;31m\]\u@\h\[\033[0m\] \[\033[32m\]\w\[\033[0m\]]\\$ "
                else
                    PS1="[\[\033[1;31m\]\u@\h (env from ${LOGNAME}!)\[\033[0m\] \[\033[32m\]\w\[\033[0m\]]\\$ "
                fi
            fi

        fi
    fi
fi
