# Editors
export EDITOR="nvim"
export VISUAL="nvim"

# XDG
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# ZSH
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export SHELL_SESSION_DIR="${XDG_STATE_HOME}/zsh/sessions"
export SHELL_SESSION_FILE="${SHELL_SESSION_DIR}/${TERM_SESSION_ID}"
export CLICOLOR=1

# KDE
export KDEHOME="${XDG_CONFIG_HOME}/kde"

# xorg-xauth
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"

# Homebew
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"
export HOMEBREW_NO_ANALYTICS=1

# Starship
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"

# Python / Jupyter / Conda
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_PLATFORM_DIRS="1"
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"
export WORKON_HOME="${XDG_DATA_HOME}/virtualenvs"

# R Lang
export RENV_PATHS_CACHE="${XDG_CACHE_HOME}/renv"

# Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# k9s
export K9SCONFIG="${XDG_CONFIG_HOME}/k9s"

# kubernetes
export KUBECONFIG="${XDG_CONFIG_HOME}/kube"

# aws-cli
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# azure-cli
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"

# ripgrep
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

# zoxide
export _ZO_ECHO=1
#export _ZO_FZF_OPTS=

# bat
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/bat.conf"

# fzf
export FZF_CTRL_T_OPTS="--height 60% \
--border sharp \
--layout reverse \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cfg -l -g ""'

# bmks
export URL_FILE_PATH="${XDG_DATA_HOME}/bmks"

# nix
export NIX_CONF_DIR="${XDG_CONFIG_HOME}/nix"
# export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

