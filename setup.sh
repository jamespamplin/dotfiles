#!/usr/bin/env bash

echo "Setting up the user environment..."


echo "Cloning dotfiles..."
git clone --bare https://github.com/jamespamplin/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no


echo "Installing XCode command line tools..."
if xcode-select --print-path &>/dev/null; then
  echo "XCode command line tools already installed."
elif xcode-select --install &>/dev/null; then
  echo "Finished installing XCode command line tools."
else
  echo "Failed to install XCode command line tools."
fi

sudo -v


if -z `which brew`; then
  echo "Installing homebrew..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi


echo "Installing Brewfile packages..."
brew bundle
echo "Finished installing Brewfile packages."

if -z `grep fish /etc/shells`; then
  which fish | sudo tee -a /etc/shells
fi

echo "Use fish shell"
chsh -s `which fish`

if ! -e $HOME/.local/share/omf; then
  echo "Installing oh-my-fish..."
  curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

  echo 'omf doctor' | fish
  echo 'omf install' | fish
  echo "Finished installing oh-my-fish."
fi


echo "Setting up 1password symlink for ssh agent"
mkdir -p ~/.1password && ln -fs ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock


echo "Using ssh for dotfiles repo"
config remote set-url origin git@github.com:jamespamplin/dotfiles.git

echo "Done!"
