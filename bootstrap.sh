#!/bin/bash

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

if [[ ${USER} == "codespace" ]]; then
  rm ~/.zshrc
  create_symlinks
fi

if hash brew 2>/dev/null; then
  apt-get install build-essential -y
  /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
   echo "Brew already installed!"
fi