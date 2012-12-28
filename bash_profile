### Global ###

# Source non-login rc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
export CLICOLOR=1
export TERM="xterm-color"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%.local}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

#if [ -f ~/.t11e ]; then
#  . ~/.t11e
#fi
if [ -f ~/.pw ]; then
  . ~/.pw
fi
if [ -f ~/.smp ]; then
  . ~/.smp
fi
if [ -f ~/.local ]; then
  . ~/.local
fi

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
