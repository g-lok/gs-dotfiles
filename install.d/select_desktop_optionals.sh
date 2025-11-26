#!/usr/bin/env bash

## Select DBs
OPTIONAL_DESKTOP_APPS=(
  "1password"
  "Spotify"
  "Zoom"
  "Dropbox"
)
export CHOSEN_OPT_DESKTOP_APPS=$(gum choose "${OPTIONAL_DESKTOP_APPS[@]}" --no-limit --height 5 --header "Select optional desktop applications.")
