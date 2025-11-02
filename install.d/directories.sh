#!/usr/bin/env bash

## Folders to Create in Home
folders=(
  /Downloads/Torrents/
  /Downloads/Chrome
  /Downloads/Firefox
  /Downloads/Brave
  /Documents/Personal/
  /Documents/Professional
  /Documents/Saved-Websites
  /gitclones
  /bin
  /Google-Drive
  /Pictures/Screenshots
  /Pictures/Wallpapers
  /Projects
  /Go/src
)

## Function that creates folders
for dir in "${folders[@]}"; do
  fullpath="$HOME/$dir"
  sudo mkdir -p "$fullpath"
done
echo "Folders created."
