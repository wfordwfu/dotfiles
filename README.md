# dotfiles

This project is an attempt to standardize my workspace between my various machines (Mac, ChromeOS, Windows, Codespaces).  I'm probably not going to have everything working in all of those environments (specifically Windows), but that is ultimately my goal.

I'm in the process of building up the Neovim config files.  I'm impressed with the work chrisatmachine.com has done with LunarVim, so I'm using that heavily for my inspiration.

## Getting Started

### Prerequsites

- Homebrew - while a popular application manager for Mac, brew is quite capable on Linux as well. The install script can be found at https://brew.sh/.
- ZSH - if you are running a recent Mac, you should be running zsh already.  If Debian, you can install via APT (`sudo apt install zsh`).  You should also change your default shell (`chsh $(which zsh)` or `sudo chsh $(which zsh) $USER`).  It's also possible to install zsh using brew.
- Git - Probably best to install via brew

### Why Homebrew?  This isn't a Mac

I may come across a better solution in the future, but prior to this I would write a bunch of ansible scripts to install applications the "right" way, which typically included adding some repo to apt and a slightly different solution for yum and so forth.  This isn't a terrible solution and if it's something I want to install on a production server for instance, sure I'd probably go this way.  But in the usecase of a user space where I want to have the newest version without any hassle and install on many different distros, Homebrew works great.  The only limitation I'm aware of is the "--cask" option doesn't work on Linux, but my understanding is that is really intended to solve a Mac problem.

### How to install

[How to Store Dotfiles](https://atlassian.com/git/tutorials/dotfiles) - I strongly recommend you read this.  The quick instructions to install this repo are as follows:
- back up anything in your home directory.  even if you just create a directory that doesn't exist in the current project(.backup or something) and move everything there.
- `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
- `mkdir -p $HOME/.cfg`
- `git clone --bare https://github.com/wfordwfu/dotfiles.git $HOME/.cfg`
- `config checkout`
- `config config --local status.showUntrackedFiles no`

## Stack

- [zsh](https://www.zsh.org/)
- [git](https://git-scm.com/)
- [Homebrew](https://brew.sh/)
- [Neovim](https://neovim.io/)

## Reference

- [GitHub does dotfiles](https://dotfiles.github.io)
- [How to Store Dotfiles](https://atlassian.com/git/tutorials/dotfiles)
- [XDG Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
- [LunarVim - nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide)

