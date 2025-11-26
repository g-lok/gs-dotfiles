#!/usr/bin/env bash

## Install Selected Desktop Apps

if [[ ${#CHOSEN_OPT_DESKTOP_APPS[@]} -gt 0 ]]; then
  for option in "${CHOSEN_OPT_DESKTOP_APPS[@]}"; do
    case ${option} in
    1password)
      brew install --cask 1password
      ;;
    Spotify)
      brew install --cask spotify
      ;;
    Zoom)
      brew install --cask zoom
      ;;
    Dropbox)
      brew install --cask dropbox
      ;;
    esac
  done
fi
