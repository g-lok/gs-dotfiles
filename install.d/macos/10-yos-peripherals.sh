#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

###############################################################################
# Mice, keyboard, etc                                                         #
###############################################################################
# Set a blazingly fast keyboard repeat rate
sudo -u $dotfiles_usr defaults write NSGlobalDomain KeyRepeat -int 0

# disable Natural scrolling
# sudo -u $dotfiles_usr defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
