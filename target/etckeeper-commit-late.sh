#!/bin/bash
if [ ! -x /usr/bin/etckeeper ] ; then
    exit 0
fi

# workaround for "fatal: $HOME is not set"
if [ -z "$HOME" ] ; then
    export HOME=/root
fi

/usr/bin/etckeeper commit "Second commit"    >/dev/null

/usr/bin/etckeeper vcs gc    >/dev/null

exit 0
