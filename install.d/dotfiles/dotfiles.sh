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
  "neovim"
  "shellrc"
  "starship"
  "VSCode"
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
    arch="arm64"
  else
    arch="intel"
  fi

  # alacritty configs
  stow --target="$HOME" --adopt "alacritty-macos-${arch}"
  stow --target="$HOME" --restow "alacritty-macos-${arch}"

  # ghostty configs
  stow --target="$HOME" --adopt "ghostty-macos-${arch}"
  stow --target="$HOME" --restow "ghostty-macos-${arch}"

  # zellij configs
  stow --target="$HOME" --adopt "zellij-macos-${arch}"
  stow --target="$HOME" --restow "zellij-macos-${arch}"
  ;;

*)
  return
  ;;
esac
