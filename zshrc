#! /bin/zsh

# Load completion system and zrecompile for faster startup
autoload -U compinit zrecompile

###
# Basic terminal configuration
export TERM=xterm-256color  # Set terminal to support 256 colors
autoload -U colors
colors  # Enable color support

# Load custom functions from ~/.zsh.d/functions
# Source: http://sebastiancelis.com/2009/nov/16/zsh-prompt-git-users/
fpath=(~/.zsh.d/functions $fpath)
autoload -U ~/.zsh.d/functions/*(:t)

# Initialize function arrays for hooks
typeset -ga preexec_functions  # Functions to run before command execution
typeset -ga precmd_functions   # Functions to run before prompt display
typeset -ga chpwd_functions    # Functions to run when directory changes
 
# Add git-related functions to the hooks
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Disable automatic command correction
unsetopt correct

# Set up completion cache directory
zsh_cache=${HOME}/.zsh_cache
mkdir -p $zsh_cache

# Initialize completion system with caching for non-root users
if [ $UID -eq 0 ]; then
        compinit
else
        compinit -d $zsh_cache/zcomp-$HOST

        # Recompile completion cache for faster loading
        for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
                zrecompile -p $f && rm -f $f.zwc.old
        done
fi

# Load additional zsh configuration files
setopt extended_glob
for zshrc_snipplet in ~/.zsh.d/[0-9][0-9]*[^~] ; do
        source $zshrc_snipplet
done

# Load local configuration files if they exist
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Set terminal title to show user@host - current directory
case $TERM in (xterm*|rxvt|screen)
  precmd () { print -Pn "\e]0;${(%):-%n@%m - %~}\a" }
esac

# Custom aliases and functions
alias rake="noglob rake"  # Disable globbing for rake commands
# Autojump function with colored output
function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }

# Initialize nodenv (Node.js version manager)
eval "$(nodenv init -)"

