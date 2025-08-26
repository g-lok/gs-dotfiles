#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

sudo -u $dotfiles_usr defaults write com.apple.screencapture location $dotfiles_usr_home/Pictures/Screenshots
killall SystemUIServer
