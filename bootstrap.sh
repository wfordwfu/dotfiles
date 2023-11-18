#!/usr/bin/env bash

create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(
    find -path "./.*" -maxdepth 1 -not \( -path "./.git*" -maxdepth 1 -prune \)
    )   

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

if [[ $(hostname -s) = codespace* ]]; then
#  rm ~/.zshrc
  create_symlinks
fi

if hash brew 2>/dev/null; then
  echo "##################################################"
  echo "Brew already installed!!!"
  echo "##################################################"
else
  source /dev/stdin  <<< "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if hash yum 2>/dev/null; then
    sudo yum upgrade
    sudo yum install gcc gcc-c++ kernel-devel make
  else
    sudo apt-get update -y
    sudo apt-get install build-essential procps -y
  fi
fi

if hash zsh 2>/dev/null; then
  echo "##################################################"
  echo "ZSH already installed"
  echo "##################################################"
else
  if hash yum 2>/dev/null; then
    sudo yum upgrade
    sudo yum install zsh
  else
    sudo apt-get update -y
    sudo apt-get install zsh -y
  fi
fi

if hash code 2>/dev/null; then
  echo "##################################################"
  echo "VSCode cli is available"
  echo "##################################################"
#  if ! code --list-extensions | grep -q "github.copilot"; then
    # Install GitHub Copilot
#    code --install-extension GitHub.copilot
#    code --install-extension GitHub.copilot-chat
#  fi
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
fi