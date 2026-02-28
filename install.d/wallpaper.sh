#!/usr/bin/env bash

cp "$GSDOT_PATH/themes/victorian-wallpaper.jpg" ~/Pictures/Wallpapers/

case "$SCRIPT_OS" in
"MacOS")
  filepath="$HOME/Pictures/Wallpapers/victorian-wallpaper.jpg"
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"$filepath"'"'
  ;;
"linux_gui")
  gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/wallpaper.jpg"
  ;;
*)
  echo "Not a valid OS to set desktop wallpaper."
  ;;
esac
