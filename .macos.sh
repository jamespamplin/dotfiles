#!/usr/bin/env bash

## See https://github.com/mathiasbynens/dotfiles/blob/main/.macos for full list

set -e

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Set dock to the left
defaults write com.apple.dock orientation -string left

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Clear dock
defaults write com.apple.dock persistent-apps -array

# Don't show recent apps in dock and clear recents
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock recent-apps -array

killall Dock
