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
#export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export SHELL_SESSION_DIR="${XDG_STATE_HOME}/zsh/sessions"
export SHELL_SESSION_FILE="${SHELL_SESSION_DIR}/${TERM_SESSION_ID}"

# Starship
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/.starship"

