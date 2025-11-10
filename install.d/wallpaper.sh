#!/usr/bin/env bash

cp "$GS_DOTFILES_PATH/themes/victorian-wallpaper.jpg" ~/Pictures/Wallpapers/

case "$SCRIPT_OS" in
"MacOS")
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file '"$HOME/Pictures/Wallpapers/victorian-wallpaper.jpg"
  ;;
"linux_gui")
  gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/wallpaper.jpg"
  ;;
*)
  echo "Not a valid OS to set desktop wallpaper."
  ;;
esac
