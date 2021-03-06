#!/usr/bin/env bash

echo "Setting up the user environment..."

# Oh my zsh for dotfiles
# curl -L http://install.ohmyz.sh | sh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# Install homeshick, checkout dotfiles
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone -b jamespamplin/dotfiles
homeshick link -b dotfiles
