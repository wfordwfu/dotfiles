HISTSIZE=1000
SAVEHIST=1000
bindkey -v

if [[ ! -d ${XDG_STATE_HOME}/zsh ]]; then
  mkdir -p ${XDG_STATE_HOME}/zsh
fi

autoload -Uz compinit promptinit
compinit
promptinit

if [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  brewpath="/home/linuxbrew/.linuxbrew/bin"
else
  brewpath="/opt/homebrew/bin"
fi

typeset -U path PATH
path=(${HOME}/.local/bin $brewpath $path)

export PATH

alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    "${XDG_CONFIG_HOME}/zsh/zfuncs"
    "${fpath[@]}"
)

#autoload -Uz ${fpath}[1]/*(.:t)
autoload -Uz gitenv 
gitenv

if hash starship 2>/dev/null; then
  echo "#####################################################"
  echo "Run brew bundle to install/update additional features"
  echo "#####################################################"
else
  ${brewpath}/brew install -q starship
  ${brewpath}/brew install -q zsh-autosuggestions
  ${brewpath}/brew install -q zsh-syntax-highlighting
  ${brewpath}/brew install -q fnm
  ${brewpath}/brew install -q wget
fi

eval "$(starship init zsh)"

eval "$(fnm env --use-on-cd)"

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

