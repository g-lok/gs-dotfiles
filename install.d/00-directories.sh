#!/usr/bin/env bash

## Folders to Create in Home
folders=(
  /Downloads/Torrents/Incomplete
  /Downloads/Torrents/Complete
  /Downloads/Chrome
  /Downloads/Firefox
  /Downloads/Brave
  /Documents/Personal/Development
  /Documents/Saved-Websites
  /Documents/Professional
  /gitclones
  /bin
  /Google-Drive
  /Pictures/Screenshots
  /Projects/Music/Projects/Music/Projects/Music
  /Projects/Coding
  /Go/src
  /.shellrc
)

## Function that creates folders
create_folders() {
  for dir in "${folders[@]}"; do
    fullpath="$HOME/$dir"
    mkdir -p "$fullpath"
  done
}
create_folders
echo "Folders created."
