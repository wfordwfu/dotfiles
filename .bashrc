echo "##################################################"
echo "please run brew bundle to install any dependencies"
echo "##################################################"
sudo chsh -s $(which zsh) ${USER}

sudo apt-get install build-essential cowsay procps -y

if hash brew 2>/dev/null; then
  /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
