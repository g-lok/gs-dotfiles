#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs

## Set current working directory to dotfiles folder
cd "$(dirname "$0")" || exit 0

## Get the script path while we're at it
export DOTFILES_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

## GNU STow to set up configs
export STOW_CONFIGS=dirs=(*/)
echo $STOW_CONFIGS
for config in "${STOW_CONFIGS[@]}"; do
  ## stow adopt it first before anything to keep the user's existing configs safe
  stow --target="$HOME" --adopt "$config"
  ## stow restow to make it clean
  stow --target="$HOME" --restow "$config"
done

# stow --target="$HOME" --restow $DOTFILES_SCRIPT_PATH/dotfiles/*
