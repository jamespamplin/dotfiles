#!/usr/bin/env bash
set -e

echo "Setting up the user environment..."


echo "Installing XCode command line tools..."
if xcode-select --print-path &>/dev/null; then
  echo "XCode command line tools already installed."
elif xcode-select --install &>/dev/null; then
  echo "Finished installing XCode command line tools."
else
  echo "Failed to install XCode command line tools."
fi

function config {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

if [ ! -e $HOME/.cfg ]; then
  echo "Cloning dotfiles..."
  git clone --bare https://github.com/jamespamplin/dotfiles.git $HOME/.cfg
  config checkout
  config config --local status.showUntrackedFiles no
fi


if [ -z `which brew` ]; then
  echo "Installing homebrew..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

  if [ -e /usr/local/Homebrew/bin/brew ]; then
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
  else
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi


echo "Installing Brewfile packages..."
brew bundle
echo "Finished installing Brewfile packages."

if [ -z `grep fish /etc/shells` ]; then
  which fish | sudo tee -a /etc/shells
fi


if [[ ! $SHELL =~ "fish" ]]; then
  echo "Use fish shell"
  chsh -s `which fish`
fi

if [ ! -e $HOME/.local/share/omf ]; then
  echo "Installing oh-my-fish..."
  curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

  echo "omf doctor" | fish
  echo "omf install" | fish
  echo "Finished installing oh-my-fish."
fi


echo "Setting up 1password symlink for ssh agent"
mkdir -p ~/.1password && ln -fs ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock


echo "Using ssh for dotfiles repo"
config remote set-url origin git@github.com:jamespamplin/dotfiles.git


echo "Setting macos preferences"
./.macos.sh


echo "Done!"
