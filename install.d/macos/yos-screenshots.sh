#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

sudo -A -u "$CURRENT_USER" defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
killall SystemUIServer
