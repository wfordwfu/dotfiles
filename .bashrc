sudo chsh -s $(which zsh) ${USER}

if hash starship 2>/dev/null; then
  brew upgrade starship
else
  brew install -q starship
  brew install -q zsh-autosuggestions
  brew install -q zsh-syntax-highlighting
  brew install -q fnm
fi

eval zsh