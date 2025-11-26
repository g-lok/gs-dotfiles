#!/usr/bin/env bash

## Get user input
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Gs-Dotfiles" "Let's get started!"

export NAME=$(gum input --prompt "Please enter full name: ")
export EMAIL=$(gum input --prompt "Please enter email: ")
export HOMEBREW_PASSWORD=$(gum input --password --prompt "Please enter password: ")
