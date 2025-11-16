#!/usr/bin/env bash

## Folders to Create in Home
folders=(
  Downloads/Torrents/
  Downloads/Chrome
  Downloads/Firefox
  Downloads/Brave
  Documents/Personal/
  Documents/Professional
  Documents/Saved-Websites
  gitclones
  bin
  Pictures/Screenshots
  Pictures/Wallpapers
  Projects
)

## Function that creates folders
for dir in "${folders[@]}"; do
  fullpath="$HOME/$dir"
  mkdir -p "$fullpath"
done
