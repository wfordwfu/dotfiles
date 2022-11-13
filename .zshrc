HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit promptinit
compinit
promptinit

typeset -U path PATH
path=(~/.local/bin /opt/homebrew/bin /home/linuxbrew/.linuxbrew/bin $path)

export PATH

alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

eval "$(starship init zsh)"
