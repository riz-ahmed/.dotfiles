#!/usr/bin/zsh

autoload -U colors && colors
autoload -Uz compinit && compinit       # zsh autocomplete system
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# EMACS keybindings
bindkey -e

setopt autocd		# automatically cd into typed direcorty
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{magenta}%~%F{red}]%f%b "
PS2="%BF{blue}>%f%b"
stty stop undef		# disable ctrl-s to avoid terminal freezing
setopt interactive_comments

# setting defualt editor (nvim)
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"

# load aliases 
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# mail settings
set -o mailwarn

# histroy control
HISTCONTROL=ignorespace:ignoredups
HISTFILESIZE=500
FCEDIT="$(which nvim)"

# update PATH
PATH=$PATH":$HOME/.config/shell_scripts"

# # plugins
# enabling zoxide
eval "$(zoxide init zsh)"

