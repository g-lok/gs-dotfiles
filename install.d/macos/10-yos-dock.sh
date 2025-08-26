#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

# Faster Dock
sudo -u $dotfiles_usr defaults write com.apple.Dock autohide-delay -float 0.1
sudo -u $dotfiles_usr defaults write com.apple.dock autohide-time-modifier -float 0.5

#
sudo -u $dotfiles_usr defaults write com.apple.dock largesize -float 150.000000

#
sudo -u $dotfiles_usr defaults write com.apple.dock static-only -bool TRUE; 

#Automatically hide and show the Dock
sudo -u $dotfiles_usr defaults write com.apple.dock autohide -bool true

#Enable gestures
#sudo -u $dotfiles_usr defaults write com.apple.dock scroll-to-open -bool TRUE; killall Dock

# Make Dock icons of hidden applications translucent
sudo -u $dotfiles_usr defaults write com.apple.dock showhidden -bool true

# Dim hidden apps
sudo -u $dotfiles_usr defaults write com.apple.dock showhidden -bool TRUE; killall Dock

# Kill the dock, so that it will restart and all changes should be observed
killall Dock
