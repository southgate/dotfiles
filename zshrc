#! /bin/zsh
autoload -U compinit zrecompile

###
export TERM=xterm-256color
autoload -U colors
colors
# From http://sebastiancelis.com/2009/nov/16/zsh-prompt-git-users/
fpath=(~/.zsh.d/functions $fpath)
autoload -U ~/.zsh.d/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

unsetopt correct

zsh_cache=${HOME}/.zsh_cache
mkdir -p $zsh_cache

if [ $UID -eq 0 ]; then
        compinit
else
        compinit -d $zsh_cache/zcomp-$HOST

        for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
                zrecompile -p $f && rm -f $f.zwc.old
        done
fi

setopt extended_glob
for zshrc_snipplet in ~/.zsh.d/[0-9][0-9]*[^~] ; do
        source $zshrc_snipplet
done

if [ -f ~/.local ]; then
  source ~/.local
fi

if [ -f ~/.pw ]; then
  source ~/.pw
fi
if [ -f ~/.smp ]; then
  source ~/.smp
fi


### set title block 
case $TERM in (xterm*|rxvt|screen)
  precmd () { print -Pn "\e]0;${(%):-%n@%m - %~}\a" }
esac
#### end set-title-block


alias rake="noglob rake"
function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }
