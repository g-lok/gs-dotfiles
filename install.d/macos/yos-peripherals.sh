#!/usr/bin/env bash

## Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

export CURRENT_USER=$(stat -f %Su /dev/console)
export USER_ID=$(id -u "$CURRENT_USER")
###############################################################################
# Mice, keyboard, etc                                                         #
###############################################################################
## Set a blazingly fast keyboard repeat rate
sudo -A -u "$CURRENT_USER" defaults write NSGlobalDomain KeyRepeat -int 0

# disable Natural scrolling
# sudo -u "$CURRENT_USER" defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
