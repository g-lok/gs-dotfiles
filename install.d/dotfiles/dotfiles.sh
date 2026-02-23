#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs

## Set current working directory to dotfiles folder
cd "$(dirname "$0")" || exit 0

OS=$(uname -s)
if [[ "$(uname -m)" == "arm64" ]]; then
  arch="arm64"
else
  arch="intel"
fi
## Get the script path while we're at it
export GSDOT_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
stow_and_copy () {
  config=$1
## GNU Stow to set up non-OS specific configs
  ## stow adopt it first before anything to keep the user's existing configs safe
  stow --target="$HOME" --adopt "$config"
  ## stow restow to make it clean
  stow --target="$HOME" --restow "$config"
  cp -r "$GSDOT_SCRIPT_PATH/$config" "$HOME/dotfiles/"
}
## We doing this precise and intentional baby
GSDOT_UNIVERSAL=(
  "alacritty"
  "bash"
  "btop"
  "ghostty"
  "neovim"
  "shellrc"
  "starship"
  "VSCode"
  "yazi"
  "zellij"
  "zsh"
)

gum style \
  --bold "GNU Stow/Adopt/Copy the following configs to ~/dotfiles."\
"If you don't know what this means, just select them all with ctrl+a."
GSDOT_CHOICES=$(gum choose --no-limit "${GSDOT_UNIVERSAL[@]")
## GNU Stow to set up non-OS specific configs
# for config in "${GSDOT_UNIVERSAL[@]}"; do
#   ## stow adopt it first before anything to keep the user's existing configs safe
#   stow --target="$HOME" --adopt "$config"
#   ## stow restow to make it clean
#   stow --target="$HOME" --restow "$config"
# done
for choice in "${GSDOT_CHOICES[@]}"; do
  case $choice in
  # alacritty)
  #   case $OS in
  #     Linux)
  #       stow_and_copy("alacritty-linux")
  #     ;;
  #     Darwin)
  #       stow_and_copy("alacritty-macos-${arch}")
  #     ;;
  #   esac
  #   ;;
    "ghostty")
    stow_and_copy("ghostty-macos-${arch}")
    ;;
   "zellij")
    stow_and_copy("zellij-macos-${arch}")
    ;;
    "bash")
    stow_and_copy("bash")
    ;;
    "btop")
    stow_and_copy("btop")
    ;;
    "neovim")
    stow_and_copy("neovim")
    ;;
    "shellrc")
    stow_and_copy("shellrc")
    ;;
    "starship")
    stow_and_copy("starship")
    ;;
    "VSCode")
    stow_and_copy("VSCode")
    ;;
    "yazi")
    stow_and_copy("yazi")
    ;;
    "zsh")
    stow_and_copy("zsh")
    ;;
    *)
    return
    ;;
  esac
done

