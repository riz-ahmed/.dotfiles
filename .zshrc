#!/usr/bin/zsh

autoload -U colors && colors
autoload -Uz compinit && compinit       # zsh autocomplete system
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# EMACS keybindings
bindkey -e

setopt autocd		# automatically cd into typed direcorty
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{magenta}%~%F{red}]%f%b "
PS2="%B%F{blue}>>>%f%b "
stty stop undef		# disable ctrl-s to avoid terminal freezing
setopt interactive_comments

# tell fzf to use ripgrep
if type rg &> /dev/null; then				# if ripgrep exists
  export FZF_DEFAULT_COMMAND='rg --files'		# use ripgrep for fzf
  export FZF_DEFAULT_OPTS='-m'				# make multiple selections using <Tab> or <Shift-Tab>
fi

# setting defualt editor (nvim)
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export BROWSER="$(which qutebrowser)"

# load aliases 
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# mail settings
set -o mailwarn

# histroy control
HISTCONTROL=ignorespace:ignoredups
HISTFILESIZE=500
FCEDIT="$(which nvim)"

# update PATH
# PATH=$PATH":$HOME/.config/shell_scripts"

# # plugins
# enabling zoxide
eval "$(zoxide init zsh)"

