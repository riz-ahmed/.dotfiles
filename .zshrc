#!/usr/bin/zsh

autoload -U colors && colors

# use modern zsh completion system
autoload -Uz compinit && compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format "Completing %d"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# EMACS keybindings
autoload -Uz select-word-style  # M navitagation just like in Emacs
select-word-style bash
bindkey -e

# emacs daemon
start_emacs() {
    if ! pgrep -x "emacs" > /dev/null; then
        echo "starting emacs daemon..."
        emacs --daemon
    fi
}

start_emacs

# prompt
setopt autocd		# automatically cd into typed direcorty
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{magenta}%~%F{red}]%f%b "
PS2="%B%F{blue}>>>%f%b "
stty stop undef		# disable ctrl-s to avoid terminal freezing
setopt interactive_comments

# colorised output
# 1. colored GCC errors and warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01'

# 2. colorised gitdiff using bat
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

# 3. colorised man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"          # due to formatting problems with man pages

# 4. colorised --help
alias bathelp='bat --plain --language=help'

# config only for zsh
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# tell fzf to use ripgrep
if type rg &> /dev/null; then				# if ripgrep exists
  export FZF_DEFAULT_COMMAND='rg --files'		# use ripgrep for fzf
  export FZF_DEFAULT_OPTS='-m'				# make multiple selections using <Tab> or <Shift-Tab>
fi

# setting defualt editor (nvim)
export EDITOR='$(which nvim)'
export VISUAL='emacsclient -cnqu'
export BROWSER="$(which firefox)"
export LESS='-R --use-color -Dd+r$Du+b$'        # less command with color output
# viman () { text=$(man "$@") && echo "$text" | vim -R +":set ft=man" - ; }


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
FCEDIT="$(which emacsclient -cnqu)"

# updaet run-help to improve its functionality to work on shell built-ins and shell commands
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# set us-keyboard as default
setxkbmap -layout us

# path variable
PATH=$HOME/.local/bin:$PATH

# add zoxide binary
eval "$(zoxide init zsh)"

# add brew package manager to PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
