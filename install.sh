#!/usr/bin/env bash

# set -e

## G's set-up scripts for MacOS and Linux
## Export cwd and generic script directories
# export GS_DOTFILES_PATH=$(dirname "$(readlink -f "$0")")
export GSDOT_PATH="$HOME/.local/share/gsdotfiles"
export GSDOT_SCRIPTS="$GSDOT_PATH/install.d"
export GSDOT_DOTFILES="$GSDOT_PATH/install.d/dotfiles"

## Print logo
case $BASH_VERSION in
4.* | 5.* | 6.*)
  source "$GSDOT_SCRIPTS/ascii.sh"
  ;;
*)
  cat <<'EOF'
  ________                 ________          __    _____.__.__                 
 /  _____/  ______         \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  ______  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \  /_____/  |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  >         /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/                  \/                                \/     \/
EOF
  ;;
esac

## Begin
echo -e "\nBegin installation (or abort with ctrl+c)..."

## Make sure sudo is already cached before using gum spinner or anything that will interfere with the scripts
sudo --validate

## Make all scripts executable
for file in $GSDOT_PATH/install.d/*.sh; do
  chmod +x "$file"
done

## Set OS
source "$GSDOT_SCRIPTS/get_os.sh"

## Install package managers and gum
source "$GSDOT_SCRIPTS/install_pkgmgr_gum.sh"

## Set gum color scheme
source "$GSDOT_SCRIPTS/set_gum_flags.sh"

## Get user input
source "$GSDOT_SCRIPTS/inst_user_input.sh"

## STOP ASKING ME FOR SUDO!
export SUDO_ASKPASS="$GSDOT_SCRIPTS/returnpass.sh"

## Create directories under home
gum spin --spinner moon --title "Creating directories..." -- sleep 2
source "$GSDOT_SCRIPTS/directories.sh"

## Run installation scripts based on OS
gum style \
  --bold "Running Installation and Configuration Scripts"
case $SCRIPT_OS in
"MacOS")
  source "$GSDOT_SCRIPTS/macos/launch.sh"
  ;;
*)
  echo "Unrecognized OS. Skipping installation and configuration."
  ;;
esac

## Setup dotfiles
gum style \
  --bold "GNU Stow Adopted existing configs to this repo." "Do you want to use G's Dotfile Configs instead?"
gum confirm && git restore . || echo "No git actions taken. Using adopted configs."

gum style \
  --bold "Set wallpaper to theme?"
gum confirm && source "$GSDOT_PATH/install.d/wallpaper.sh" || echo "Wallpaper unchanged"

gum style \
  --bold "Congratulations!" "Installation and Configuration Complete!"

## remove env variables
unset HOMEBREW_PASSWORD
unset APP_CATEGORIES
unset EMAIL
unset NAME
unset GSDOT*
unset STOW_CONFIGS
unset SCRIPT_OS
