echo "##################################################"
echo "please run brew bundle to install any dependencies"
echo "##################################################"
sudo chsh -s $(which zsh) ${USER}

if hash brew 2>/dev/null; then
  sudo apt-get update
  sudo apt-get install build-essential cowsay procps -y
  bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


eval zsh