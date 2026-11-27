
# Load Bootstrap functions

if [[ -r $ZDOTDIR/bootstrap.zsh ]]; then
  source $ZDOTDIR/bootstrap.zsh
else
  print -u2 "zshrc: bootstrap.zsh missing"
fi

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

if [[ ! -d ${XDG_STATE_HOME}/zsh ]]; then
  mkdir -p ${XDG_STATE_HOME}/zsh
fi

if [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  brewpath="/home/linuxbrew/.linuxbrew/bin"
else
  brewpath="/opt/homebrew/bin"
fi

if [[ -d /opt/mssql-tools18/bin ]]; then
  mssqltoolspath="/opt/mssql-tools18/bin"
fi

if command -v uv >/dev/null 2>&1; then
  uvpath="${UV_TOOL_BIN_DIR}"
fi


typeset -U path PATH
path=(
  ${HOME}/.local/bin
  ${GOPATH}/bin
  ${CARGO_HOME}/bin
  ${uvpath}
  ${mssqltoolspath}
  ${brewpath}
  ${path}
)

export PATH

alias config="$(which git) --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    "${XDG_CONFIG_HOME}/zsh/zfuncs"
    "${fpath[@]}"
)

if ! command -v pbcopy >/dev/null 2>&1; then
    if command -v xsel >/dev/null 2>&1; then
        alias pbcopy='xsel --input --clipboard'
    else
        echo "please run brew install xsel to get pbcopy/pbpaste support"
    fi
fi
if ! command -v pbpaste >/dev/null 2>&1; then
    if command -v xsel >/dev/null 2>&1; then
        alias pbpaste='xsel --output --clipboard'
    fi
fi

zfuncs_load gitenv

zfuncs_load --run sshconfig

zfuncs_load --run sshcontrolmaster

zfuncs_periodic dotfiles-test 1d --run "$HOME/.local/bin/dotfiles-test"

zfuncs_load tmuxsetup && zfuncs_periodic tmux 1d --run tmuxsetup

zfuncs_load zplugins && zfuncs_periodic plugins 1d --run zplugins update

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
  ${brewpath}/brew install -q uv
  ${brewpath}/brew install -q pipx
  ${brewpath}/brew install -q direnv
  ${brewpath}/brew install -q zoxide
fi

if hash pipx 2>/dev/null; then
  pipx ensurepath
fi

# Load zsh completions and plugins

zfuncs_load --run completions

# Shell integrations

if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if (( $+commands[fnm] )); then
  eval "$(fnm env --use-on-cd)"
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

if (( $+commands[uv] )); then
  eval "$(uv generate-shell-completion zsh)"
fi

if (( $+commands[pyenv] )); then
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

zfuncs_load --run zle_plugins
