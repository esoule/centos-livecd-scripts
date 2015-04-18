# color-grep initialization

# Skip the rest for noninteractive shells.
[ -z "$PS1" ] && return

alias grep='grep --color=auto' 2>/dev/null
alias egrep='egrep --color=auto' 2>/dev/null
alias fgrep='fgrep --color=auto' 2>/dev/null

function lgrep()
{
  grep --color=yes "$@" | less --RAW-CONTROL-CHARS
}

function legrep()
{
  egrep --color=yes "$@" | less --RAW-CONTROL-CHARS
}

function lfgrep()
{
  fgrep --color=yes "$@" | less --RAW-CONTROL-CHARS
}

