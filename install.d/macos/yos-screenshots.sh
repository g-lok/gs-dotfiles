#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

CURRENT_USER=$(stat -f %Su /dev/console)
USER_ID=$(id -u "$CURRENT_USER")

sudo -A -u "$CURRENT_USER" defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
killall SystemUIServer
