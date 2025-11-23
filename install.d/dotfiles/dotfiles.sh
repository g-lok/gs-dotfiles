#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs

## Set current working directory to dotfiles folder
cd "$(dirname "$0")" || exit 0

## Get the script path while we're at it
export DOTFILES_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

## We doing this precise and intentional baby
UNIVERSAL_PACKAGES=(
  "bash"
  "btop"
  "ghostty"
  "shellrc"
  "VSCode"
  "zellij"
  "zsh"
)

## GNU Stow to set up non-OS specific configs
for config in "${UNIVERSAL_PACKAGES[@]}"; do
  ## stow adopt it first before anything to keep the user's existing configs safe
  stow --target="$HOME" --adopt "$config"
  ## stow restow to make it clean
  stow --target="$HOME" --restow "$config"
done

OS=$(uname -s)
case "$OS" in
"Linux")
  stow --target="$HOME" --adopt "alacritty-linux"
  stow --target="$HOME" --restow "alacritty-linux"
  ;;
"Darwin")
  if [[ "$(uname -m)" == "arm64" ]]; then
    CHIPSET="ARM64"
  else
    CHIPSET="INTEL"
  fi

  if [[ $CHIPSET == "ARM64" ]]; then
    stow --target="$HOME" --adopt "alacritty-macos-arm"
    stow --target="$HOME" --restow "alacritty-macos-arm"
  elif [[ $CHIPSET == "INTEL" ]]; then
    stow --target="$HOME" --adopt "alacritty-macos-intel"
    stow --target="$HOME" --restow "alacritty-macos-intel"
  fi
  ;;
*)
  return
  ;;
esac
