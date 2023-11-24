#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

if hash code 2>/dev/null; then
  echo "##################################################"
  echo "VSCode cli is available"
  echo "##################################################"
  if ! code --list-extensions | grep -q "github.copilot"; then
    # Install GitHub Copilot
    code --install-extension GitHub.copilot
    code --install-extension GitHub.copilot-chat
  fi
#  code --install-extension mutantdino.resourcemonitor
#  code --install-extension yzhang.markdown-all-in-one
#  code --install-extension vscode-icons-team.vscode-icons
#  code --install-extension oderwat.indent-rainbow
#  code --install-extension esbenp.prettier-vscode
#  code --install-extension vscodevim.vim
else
  echo "##################################################"
  echo "VSCode cli not available"
  echo "##################################################"

