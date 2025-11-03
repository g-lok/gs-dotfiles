#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

## Faster Dock
sudo -u "$CURRENT_USER" defaults write com.apple.Dock autohide-delay -float 0.1
sudo -u "$CURRENT_USER" defaults write com.apple.dock autohide-time-modifier -float 0.5

sudo -u "$CURRENT_USER" defaults write com.apple.dock largesize -float 150.000000

sudo -u "$CURRENT_USER" defaults write com.apple.dock static-only -bool TRUE

## Automatically hide and show the Dock
sudo -u "$CURRENT_USER" defaults write com.apple.dock autohide -bool true

## Enable gestures
#sudo -u "$CURRENT_USER" defaults write com.apple.dock scroll-to-open -bool TRUE; killall Dock

## Make Dock icons of hidden applications translucent
sudo -u "$CURRENT_USER" defaults write com.apple.dock showhidden -bool true

## Dim hidden apps
sudo -u "$CURRENT_USER" defaults write com.apple.dock showhidden -bool TRUE
killall Dock

### Replace dock items with selected app
## Backup and remove all current dock items
cp -a "~/Library/Preferences/com.apple.dock.plist" "~/Library/Preferences/com.apple.dock.plist.bkp"
defaults delete com.apple.dock persistent-apps
killall Dock

## Pin Recommended Apps
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Brave Browser.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Alacritty.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Signal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/LibreOffice.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Obsidian.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Discord.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/KeePassXC.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

## Kill the dock, so that it will restart and all changes should be observed
killall cfprefsd
killall Dock
