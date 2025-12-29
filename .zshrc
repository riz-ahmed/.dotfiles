# use modern zsh completion system
autoload -U colors && colors

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format "Completing %d"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi
# eval "$(dircolors -b)"
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

setopt autocd		# automatically cd into typed direcorty

# append path
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/Library/Python/3.9/bin:$PATH # to set the latest pip in path

# aliases
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ezsh='nvim $HOME/.zshrc'
alias man='batman'
alias nv='nvim'
alias ls='eza --icons=always'
alias ll="eza --group-directories-first -a -l --icons=always"
alias rsync="rsync -ah --info=progress2"
alias so='source $HOME/.zshrc'
alias man="batman"

# EMACS keybindings
autoload -Uz select-word-style  # M navitagation just like in Emacs
select-word-style bash
bindkey -e

# prompt
autoload -Uz vcs_info # enable version control info
precmd_vcs_info () { vcs_info } # always load before display
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PS1='%F{green}%n@%m%f %F{yellow}%B%~%b%f% %F{cyan} [${vcs_info_msg_0_}]%f %% '
zstyle ':vcs_info:git:*' formats '%b'

# disable ctrl-s to avoid terminal freezing
stty stop undef		
setopt interactive_comments

# colorised output
# 1. colored GCC errors and warnings
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01'

# 2. colorised gitdiff using bat
batdiff() {
	git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

# 3. call dirdiff
funciton dirdiff()
{
	# shell-escape each path:
	DIR1=$(printf '%q' "$1"); shift
	DIR2=$(printf '%q' "$1"); shift
	vim $@ -c "DifDiff" $DIR1 $DIR2
}

# 4. colorised --help
alias bathelp='bat --plain --language=help'

# 5. colorsized less
LESSOPEN="|/usr/local/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;
LESS="$LESS -R";
BATPIPE="color";
export LESS;
export BATPIPE;

# config only for zsh
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# tell fzf to use ripgrep
if type rg &> /dev/null; then				# if ripgrep exists
  export FZF_DEFAULT_COMMAND='rg --files'		# use ripgrep for fzf
  export FZF_DEFAULT_OPTS='-m'				# make multiple selections using <Tab> or <Shift-Tab>
fi

# setting defualt editor (nvim)
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
# export BROWSER="$(which firefox)"
#
# link libs installed using brew
export DYLD_LIBRARY_PATH="/opt/homebrew/lib/"

# updaet run-help to improve its functionality to work on shell built-ins and shell commands
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn

# plugins
eval "$(zoxide init zsh)" # zoxide
# source <(fzf --zsh) # fzf

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid 
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi  

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi  
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# shell wrapper for yazi file manager
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

[[ $TERM == "xterm-kitty" ]] && stty icrnl  # for kitty to render <enter> properly when using pass-store

source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. "$HOME/.local/bin/env"

eval "$(starship init zsh)"
