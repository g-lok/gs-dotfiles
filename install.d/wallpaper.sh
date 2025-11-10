#!/usr/bin/env bash

cp "$GS_DOTFILES_PATH/themes/victorian-wallpaper.jpg" ~/Pictures/Wallpapers/

case "$SCRIPT_OS" in
"MacOS")
  command='tell application "Finder" to set desktop picture to POSIX file '
  command_w_file="$command$HOME/Pictures/Wallpapers/victorian-wallpaper.jpg"
  filepath="$HOME/Pictures/Wallpapers/victorian-wallpaper.jpg"
  echo "$command_w_file"
  echo "$filepath"
  # osascript -e "$command_w_file"
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"$filepath"'"'
  ;;
"linux_gui")
  gsettings set org.gnome.desktop.background picture-uri "file://$HOME/Pictures/wallpaper.jpg"
  ;;
*)
  echo "Not a valid OS to set desktop wallpaper."
  ;;
esac
