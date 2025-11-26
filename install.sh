#!/usr/bin/env bash

# set -e

## G's set-up scripts for MacOS and Linux
## Export cwd and generic script directories
export GS_DOTFILES_PATH=$(dirname "$(readlink -f "$0")")
export SCRIPTS_DIR="$GS_DOTFILES_PATH/install.d"

## Print logo
source "$SCRIPTS_DIR/ascii.sh"

## Begin
echo -e "\nBegin installation (or abort with ctrl+c)..."

## Make sure sudo is already cached before using gum spinner or anything that will interfere with the scripts
sudo --validate

## Make all scripts executable
for file in $GS_DOTFILES_PATH/install.d/*.sh; do
  chmod +x "$file"
done

## MacOS or Linux?
source "$SCRIPTS_DIR/get_os.sh"

## Install package managers and gum
source "$SCRIPTS_DIR/install_pkgmgr_gum.sh"

## Get user input
source "$SCRIPTS_DIR/get_user_input.sh"

## STOP ASKING ME FOR SUDO!
export SUDO_ASKPASS="$GS_DOTFILES_PATH/install.d/returnpass.sh"
# TODO: This messes up my colors and I don't think it's necessary.
# export CI=true

## Create directories under home
gum spin --spinner moon --title "Creating directories..." -- sleep 2
source "$SCRIPTS_DIR/directories.sh"

## I lose colors here for some reason,
## so I have to set this to force colors.

# export CLICOLOR_FORCE=1
# export TERM="xterm-256color"
# export COLORTERM="24bit"

## Get installation choices
source "$SCRIPTS_DIR/installation_choices.sh"

## Run installation scripts based on OS
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Running Installation and Configuration Scripts"
case $SCRIPT_OS in
"MacOS")
  source "$SCRIPTS_DIR/macos/launch.sh"
  ;;
*)
  echo "Unrecognized OS. Skipping installation and configuration."
  ;;
esac

## Setup dotfiles
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "GNU Stow Adopted existing configs to this repo." "Do you want to use G's Dotfile Configs instead?"
gum confirm && git restore . || echo "No git actions taken. Using adopted configs."

## Setup Wallpaper
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Set wallpaper to theme?"
gum confirm && source "$GS_DOTFILES_PATH/install.d/wallpaper.sh" || echo "Wallpaper unchanged"

gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Congratulations!" "Installation and Configuration Complete!"

## remove env variables
unset HOMEBREW_PASSWORD
unset APP_CATEGORIES
unset EMAIL
unset NAME
unset GS_DOTFILES_PATH
unset DOTFILES_SCRIPT_PATH
unset STOW_CONFIGS
unset SCRIPT_OS
