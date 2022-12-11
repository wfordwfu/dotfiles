HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit promptinit
compinit
promptinit

typeset -U path PATH
path=(${HOME}/.local/bin /opt/homebrew/bin /home/linuxbrew/.linuxbrew/bin $path)

export PATH

alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

fpath=(
    "${XDG_CONFIG_HOME}/zsh/zfuncs"
    "${fpath[@]}"
)

#autoload -Uz gitenv
# autoload -Uz ${fpath}[1]/*(.:t)


eval "$(starship init zsh)"

gitenv() {
    
    if hash gh 2>/dev/null; then
      export GIT_AUTHOR_NAME=$(gh api user --jq '.name')
      export GIT_AUTHOR_EMAIL=$(gh api user --jq '(.id | tostring) + "+" + .login + "@users.noreply.github.com"')
      export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
      export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
    else
      echo "Please install gh cli"
    fi
}

gitenv

AUTOSUGGEST=$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if test -f "$AUTOSUGGEST"; then
  source "$AUTOSUGGEST"
else
  echo "Please install zsh-autosuggestions via 'brew install zsh-autosuggestions'"
fi

SYNTAXHIGHLIGHT=$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if test -f "$SYNTAXHIGHLIGHT"; then
  source "$SYNTAXHIGHLIGHT"
else
  echo "Please install zsh-syntax-highlighting via 'brew install zsh-syntax-highlighting'"
fi

