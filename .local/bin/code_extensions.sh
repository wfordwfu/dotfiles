#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

extensions=(
  "GitHub.copilot"
  "GitHub.copilot-chat"
  "vscodevim.vim"
  "vscode-icons-team.vscode-icons"
  "oderwat.indent-rainbow"
  "esbenp.prettier-vscode"
  "mutantdino.resourcemonitor"
  "yzhang.markdown-all-in-one"
)


if hash code 2>/dev/null; then
  IFS=$'\n' read -d '' -ra installed <<< $(code --list-extensions |\
    grep -v "Extensions installed")
  for extension in "${extensions[@]}"; do
    if [[ ! " ${installed[@]} " =~ " ${extension} " ]]; then
      code --install-extension ${extension}
    else
      echo " ${extension} is already installed"
    fi
  done
else
  echo "##################################################"
  echo "VSCode cli is not installed
  echo "##################################################"
  exit 1
fi

