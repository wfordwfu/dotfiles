
# Aliases

alias vim='nvim'
alias cp='cp -i'
alias mv='mv -i'
alias cat='bat'
alias ls='ls -aFh --color=always'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
alias ..='cd ..'
alias ...='cd ../..'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias MyPath='echo -e ${PATH//:/\\n}'

if ! command -v pbcopy >/dev/null 2>&1; then
    if command -v xsel >/dev/null 2>&1; then
        alias pbcopy='xsel --input --clipboard'
    fi
fi
if ! command -v pbpaste >/dev/null 2>&1; then
    if command -v xsel >/dev/null 2>&1; then
        alias pbpaste='xsel --output --clipboard'
    fi
fi

if [[ $(uname -r) =~ WSL ]]; then
    alias wopen="cmd.exe /C start 2> /dev/null"
fi

# History

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Keybindings

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion styling

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


if [[ ! -d ${XDG_STATE_HOME}/zsh ]]; then
  mkdir -p ${XDG_STATE_HOME}/zsh
fi

if [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  brewpath="/home/linuxbrew/.linuxbrew/bin"
else
  brewpath="/opt/homebrew/bin"
fi

ZINIT_HOME=${XDG_DATA_HOME}/zinit

if [[ ! -d ${ZINIT_HOME} ]]; then
  mkdir -p "$(dirname ${ZINIT_HOME})"
  git clone https://github.com/zdharma-continuum/zinit ${ZINIT_HOME}
else
  git -C ${ZINIT_HOME} pull origin main
fi

source "${ZINIT_HOME}/zinit.zsh"

if [[ -d /opt/mssql-tools18/bin ]]; then
  mssqltoolspath="/opt/mssql-tools18/bin"
fi


typeset -U path PATH
path=(${HOME}/.local/bin $mssqltoolspath $brewpath $path)

export PATH

alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    "${XDG_CONFIG_HOME}/zsh/zfuncs"
    "${fpath[@]}"
)

autoload -Uz gitenv _git_dir add_untracked
gitenv

#autoload -Uz cd
#cd

autoload -Uz sshconfig
sshconfig

autoload -Uz sshcontrolmaster
sshcontrolmaster

autoload -Uz tmuxsetup
tmuxsetup

if hash starship 2>/dev/null; then
  echo "#####################################################"
  echo "Run brew bundle to install/update additional features"
  echo "#####################################################"
else
  ${brewpath}/brew install -q starship
  ${brewpath}/brew install -q zsh-autosuggestions
  ${brewpath}/brew install -q zsh-syntax-highlighting
  ${brewpath}/brew install -q zsh-completions
  ${brewpath}/brew install -q fnm
  ${brewpath}/brew install -q wget
  ${brewpath}/brew install -q pipx
  ${brewpath}/brew install -q direnv
  ${brewpath}/brew install -q zoxide
fi

if hash pipx 2>/dev/null; then
  pipx ensurepath
fi

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

# Add in zsh plugins

zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab


# Load zsh completions

autoload -Uz compinit && compinit

#autoload -Uz compinit promptinit
#compinit
#promptinit

zinit cdreplay -q

# Shell integrations

eval "$(direnv hook zsh)"

eval "$(zoxide init --cmd cd zsh)"

eval "$(starship init zsh)"

eval "$(fnm env --use-on-cd)"

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [[ -v OldIP ]] && [[ ! "$TERM_PROGRAM" = "vscode" ]]; then
  cd ${HOME}
fi

if [[ -f "${HOME}/.ssh/github" ]]; then
  if [ -z "${SSH_AGENT_PID}" ]; then
    eval "$(ssh-agent -s)"
  fi
  ssh-add -q ${HOME}/.ssh/github
fi

