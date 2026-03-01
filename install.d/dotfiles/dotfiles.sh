#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs

## Set current working directory to dotfiles folder
cd "$(dirname "$0")" || exit 0
pwd
OS=$(uname -s)
if [[ "$(uname -m)" == "arm64" ]]; then
  arch="arm64"
else
  arch="intel"
fi
## Get the script path while we're at it
export GSDOT_DOTFILES_PATH=$(dirname "$(readlink -f "$0")")
cp -rf "$GSDOT_DOTFILES_PATH"/* "$HOME/dotfiles/"
cd "$HOME/dotfiles/"
stow_and_copy() {
  config=$1
  echo "GNU Stow Adopt/import dotfiles: $config"
  ## GNU Stow to set up non-OS specific configs
  ## stow adopt it first before anything to keep the user's existing configs safe
  stow --target="$HOME" --adopt "${config}" --override='.*'
  ## stow restow to make it clean
  stow --target="$HOME" --restow "${config}"
  cp -rf "$GSDOT_DOTFILES_PATH/$config" "$HOME/dotfiles/"
}
## We doing this precise and intentional baby
GSDOT_UNIVERSAL=(
  "alacritty"
  "bash"
  "btop"
  "ghostty"
  "golangci"
  "neovim"
  "shellrc"
  "starship"
  "VSCode"
  "yazi"
  "zellij"
  "zsh"
)

gum style \
  --bold "GNU Stow/Adopt/Copy the following configs to ~/dotfiles.\n""\
If you don't know what this means, just select them all with ctrl+a."
# export GSDOT_CHOICES=$(gum choose "${GSDOT_UNIVERSAL[@]" --no-limit --header="SSelect configs to copy.")
GSDOT_CHOICES=$(gum choose "${GSDOT_UNIVERSAL[@]}" --no-limit --height 5 --header "Select optional configs.")
## I Shouldnt have to do this, but I cant get gum choose to return a usable array
# mapfile -t GSDOT_CONF_CHOICES_MAP <<<"$GSDOT_CHOICES"
GSDOT_CONF_CHOICES_MAP=()
while IFS= read -r line; do
  GSDOT_CONF_CHOICES_MAP+=("$line")
done <<<"$GSDOT_CHOICES"
## GNU Stow to set up non-OS specific configs
# for config in "${GSDOT_UNIVERSAL[@]}"; do
#   ## stow adopt it first before anything to keep the user's existing configs safe
#   stow --target="$HOME" --adopt "$config"
#   ## stow restow to make it clean
#   stow --target="$HOME" --restow "$config"
# done
for choice in "${GSDOT_CONF_CHOICES_MAP[@]}"; do
  case $choice in
  alacritty)
    case $OS in
    Linux)
      stow_and_copy "alacritty-linux"
      ;;
    Darwin)
      stow_and_copy "alacritty-macos-${arch}"
      ;;
    esac
    ;;
  "ghostty")
    stow_and_copy "ghostty-macos-${arch}"
    ;;
  "golangci")
    stow_and_copy "golangci"
    ;;
  "zellij")
    stow_and_copy "zellij-macos-${arch}"
    ;;
  "bash")
    stow_and_copy "bash"
    ;;
  "btop")
    stow_and_copy "btop"
    ;;
  "neovim")
    stow_and_copy "neovim"
    ;;
  "shellrc")
    stow_and_copy "shellrc"
    ;;
  "starship")
    stow_and_copy "starship"
    ;;
  "VSCode")
    stow_and_copy "VSCode"
    ;;
  "yazi")
    stow_and_copy "yazi"
    ;;
  "zsh")
    stow_and_copy "zsh"
    ;;
  esac
done
