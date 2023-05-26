#!/usr/bin/env bash
set -e

echo "Setting up the user environment..."

function isAdmin {
  id -nG | grep -qw 'admin'
}

## admins will only install system level shared dependencies
if isAdmin; then
  echo "Installing XCode command line tools..."
  if xcode-select --print-path &>/dev/null; then
    echo "XCode command line tools already installed."
  elif xcode-select --install &>/dev/null; then
    echo "Finished installing XCode command line tools."
  else
    echo "Failed to install XCode command line tools."
  fi


  # rosetta for intel compatibility on mac silicon
  if pgrep -q oahd; then
    echo "Rosetta already installed"
  else
    sudo softwareupdate --install-rosetta --agree-to-license
  fi


  if [ -z `which brew` ] && [ ! -e /usr/local/Homebrew/bin/brew ] && [ ! -e /opt/homebrew/bin/brew ]; then
    echo "Installing homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
  fi
fi

## ensure homebrew and installed homebrew packages are available to this script
if [ -e /usr/local/Homebrew/bin/brew ]; then
  eval "$(/usr/local/Homebrew/bin/brew shellenv)"
elif [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
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

if isAdmin; then
  echo "Installing Brewfile packages..."
  brew bundle
  echo "Finished installing Brewfile packages."
fi

if [ -z `grep fish /etc/shells` ]; then
  if isAdmin; then
    which fish | sudo tee -a /etc/shells
  else
    echo "Error: fish missing from /etc/shells, run setup again as an admin"
    exit 1
  fi
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


if [ -z `which node` ] || [[ ! `node --version` =~ 'v18' ]]; then
  echo "Installing nodejs with nvm"
  fish -c 'nvm install 18 --lts'
  fish -c 'corepack enable'
  fish -c 'corepack prepare pnpm@latest --activate'
fi

echo "Installing local node packages"
fish -c 'pnpm add -g git-cz zx'


echo "Done!"
