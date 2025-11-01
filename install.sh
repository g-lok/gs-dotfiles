#!/usr/bin/env bash

set -e

## Personal set-up scripts for Ubuntu Linux and OSX
## Heavily inspired (*ahem* copied) by Juxtaposed, Omakub, too many to remember

## https://unix.stackexchange.com/questions/190571/sudo-in-non-interactive-script
## for idea on how to run sudo in script

cat <<"EOF"
  _______/\        ________          __    _____.__.__                 
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/
EOF
# echo -e << "EOF" "$ascii_art" EOF
echo -e "\nBegin installation (or abort with ctrl+c)..."

## Make sure sudo is already cached before using gum spinner or anything that will interfere with the scripts
sudo --validate

## Save dotfiles working directory as a variable.
## TODO: Dunno if this is necesseary
export dotfiles_wd=$(pwd)

## Exit if the script was not launched by root or through sudo
## TODO: get rid of this crap
# if [ "$EUID" -ne 0 ]; then
#   echo "The script needs to run as root" && exit 1
# fi

## MacOS or Linux?
# Get the operating system name
OS=$(uname -s)

case "$OS" in
"Linux")
  # Add Linux-specific commands here
  if [ -n "$DISPLAY" ]; then
    echo "Running on Linux (GUI)"
    export SCRIPT_OS="linux_gui"
  else
    echo "Running on Linux Headless"
    export SCRIPT_OS="linux_headless"
  fi
  ;;
"Darwin")
  echo "This script is running on macOS."
  export SCRIPT_OS="MacOS"
  ## Add macOS-specific commands here
  ## Install XCode Tools (required for Homebrew)
  if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1; then
    echo "Command Line Tools are installed"
  else
    echo "Command Line Tools are not installed"
    xcode-select --install >/dev/null
  fi
  ;;
*)
  echo "This script is running on an unknown operating system: $OS"
  # Add commands for other systems or error handling
  exit 0
  ;;
esac

## Make all scripts executable
## Is this necessary? I'm just sourcing them.
## TODO: get rid of this crap too
# for file in "$dotfiles_wd"/install.d/*.sh; do
#   chmod +x "$file"
# done

## Install Homebrew
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
else
  echo "Homebrew is already installed. Updating..."
  brew update
  brew upgrade
fi

## Temporarily load Homebrew's config and PATH and whatnot

command -v brew >/dev/null || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin" >/dev/null
command -v brew >/dev/null && eval "$(brew shellenv)" >/dev/null

## Install gum
if [[ $(command -v gum) == "" ]]; then
  brew install gum >/dev/null
else
  echo "Gum already installed"
fi

## Setup gum environment variables
export FOREGROUND="#FF0"
export BACKGROUND="#0BB"
export BORDER_FOREGROUND="212"

## Let's get started
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Gs-Dotfiles" "Let's get started!"

export PASSWORD=$(gum input --password --prompt "Please enter password: ")
# gum spin --spinner moon --title "Going for a spin..." -- sleep 4

## Create directories under home
gum spin --spinner moon --title "Creating folders" -- "$dotfiles_wd/install.d/00-directories.sh"

## Get installation choices
OPTIONAL_CATEGORIES=("Developer_Tools" "DevOps_Tools" "Artist_Tools")
export APP_CATEGORIES=$(gum choose "${OPTIONAL_CATEGORIES[@]}" --no-limit --header "Select optional application categories to install.")

## Run installation scripts based on OS
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Running Installation and Configuration Scripts"

case $SCRIPT_OS in
"MacOS")
  # gum spin --spinner moon --title "Installing Apps" -- "$dotfiles_wd/install.d/macos/yos-packages.sh"
  source "$dotfiles_wd/install.d/macos/yos-packages.sh"
  # gum spin --spinner moon --title "Changing System Settings" -- "$dotfiles_wd/install.d/macos/yos-main-configs.sh"
  # gum spin --spinner moon --title "Change Dock Settings" -- "$dotfiles_wd/install.d/macos/yos-dock.sh"
  # gum spin --spinner moon --title "Changing peripheral settings" -- "$dotfiles_wd/install.d/macos/yos-peripherals.sh"
  # gum spin --spinner moon --title "Setup Screenshots." -- "$dotfiles_wd/install.d/macos/yos-screenshots.sh"
  # gum spin --spinner moon --title "Install Oh-My-Zsh" -- "$dotfiles_wd/install.d/zsh.sh"
  ;;
esac

gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Congratulations!" "Installation and Configuration Complete!"
## remove env variables
unset dotfiles_wd
unset PASSWORD
unset APP_CATEGORIES
