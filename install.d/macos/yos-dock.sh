#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

echo "SUDO_ASKPASS=$SUDO_ASKPASS"
echo "CURRENT_USER=$CURRENT_USER"
## Faster Dock
sudo -A -u "$CURRENT_USER" defaults write com.apple.Dock autohide-delay -float 0.1
sudo -A -u "$CURRENT_USER" defaults write com.apple.dock autohide-time-modifier -float 0.5

sudo -A -u "$CURRENT_USER" defaults write com.apple.dock largesize -float 150.000000

## Only show runnings apps in dock.
## Disabled to pin ours, but uncomment if you want this
# sudo -A -u "$CURRENT_USER" defaults write com.apple.dock static-only -bool TRUE

## Automatically hide and show the Dock
sudo -A -u "$CURRENT_USER" defaults write com.apple.dock autohide -bool true

## Enable gestures
#sudo -A -u "$CURRENT_USER" defaults write com.apple.dock scroll-to-open -bool TRUE; killall Dock

## Make Dock icons of hidden applications translucent
sudo -A -u "$CURRENT_USER" defaults write com.apple.dock showhidden -bool true

## Dim hidden apps
sudo -A -u "$CURRENT_USER" defaults write com.apple.dock showhidden -bool TRUE

### Replace dock items with selected app
## TODO: Backup never works
gum style \
  --border double \
  --align center \
  --width 50 --margin "1 2" --padding "2 4" \
  --bold "Clear and replace docks items with selected apps?"
gum confirm && export CLEAR_DOCK=true || export CLEAR_DOCK=false

if [[ "$CLEAR_DOCK" == "true" ]]; then
  ## Backup and remove all current dock items
  # sudo -A -u "$CURRENT_USER" cp -a "~/Library/Preferences/com.apple.dock.plist" "~/Library/Preferences/com.apple.dock.plist.bkp"
  sudo -A -u "$CURRENT_USER" defaults delete com.apple.dock persistent-apps

  ## Pin Recommended Apps
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Brave Browser.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Ghostty.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Signal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/LibreOffice.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  if [ -d "/Applications/Visual Code.app Studio" ]; then
    sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  fi
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Obsidian.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Discord.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Spotify.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  sudo -A -u "$CURRENT_USER" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/KeePassXC.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
else
  echo "Dock unchanged."
fi

## Kill the dock, so that it will restart and all changes should be observed
killall cfprefsd
killall Dock
