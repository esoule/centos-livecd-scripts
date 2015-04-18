# Local aliases to some useful commands
#

# Skip the rest for noninteractive shells.
[ -z "$PS1" ] && return

# Turn on line wrap by default
alias minicom='/usr/bin/minicom -w'
# In netstat, show only IPv4 and IPv6 sockets (no UNIX domain sockets)
alias netstat='/bin/netstat --protocol=inet,inet6'
# Disable prompt color customizations for the shell started by the script command
alias script='PS1="\w\$ " PROMPT_COMMAND=  /usr/bin/script'

# vim:ts=4:sw=4
