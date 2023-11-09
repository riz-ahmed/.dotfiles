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
export LESS='-R --use-color -Dd+r$Du+b$'        # less command with color output
viman () { text=$(man "$@") && echo "$text" | vim -R +":set ft=man" - ; }

# load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# mail settings
set -o mailwarn

# browsing through the current directory
fcd(){cd $(ls | fzf)}

# aliases
alias cpy="xclip -selection -c" \
      h="history | cut -c 8- | sort | uniq | fzf | tr '\\n' ' ' | cpy"  \

# histroy control
HISTCONTROL=ignorespace:ignoredups
HISTFILESIZE=500
FCEDIT="$(which nvim)"

# updaet run-help to improve its functionality to work on shell built-ins and shell commands
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn
