#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs

## Set current working directory to dotfiles folder
cd "$(dirname "$0")" || exit 0

## Get the script path while we're at it
export DOTFILES_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

## GNU STow to set up configs
declare -A STOW_CONFIGS
export STOW_CONFIGS=(
  ["alacritty"]=".config/alacritty"
  ["btop"]=".config/btop"
  ["nvim "]=".config/nvim"
  ["VSCode"]=".config/Code"
  ["zellij"]=".config/zellij"
  ["shellrc"]=".shellrc"
  ["bash"]="$HOME"
  ["zsh"]="$HOME"
)

for config in "${STOW_CONFIGS[@]}"; do
  ## stow adopt it first before anything to keep the user's existing configs safe
  stow adopt --target="$HOME" --adopt "$DOTFILES_SCRIPT_PATH/dotfiles/$config"
  ## stow restow to make it clean
  stow restow --target="$HOME" --restow "$DOTFILES_SCRIPT_PATH/dotfiles/$config"
done

# stow --target="$HOME" --restow $DOTFILES_SCRIPT_PATH/dotfiles/*
