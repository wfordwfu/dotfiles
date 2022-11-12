

export PATH=/opt/homebrew/bin:$PATH


alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

eval "$(starship init zsh)"
