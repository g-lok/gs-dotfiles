#!/usr/bin/env bash

# Verbose output, including commands being run
set -x

## Personal set-up scripts for Ubuntu Linux and OSX
## Heavily inspired (*ahem* copied) by Juxtaposed, Omakub, too many to remember

## https://unix.stackexchange.com/questions/190571/sudo-in-non-interactive-script
## for idea on how to run sudo in script

ascii_art='  _______/\        ________          __    _____.__.__                 
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/ '

echo -e "$ascii_art"
echo -e "\nBegin installation (or abort with ctrl+c)..."

## Detect the user who launched the script and save relevant info.
## (this might not actually be necessary)
export dotfiles_usr=$(env | grep SUDO_USER | cut -d= -f 2)
export dotfiles_usr_home=$(sudo -u $dotfiles_usr echo $HOME)
export dotfiles_wd=$(sudo -u $dotfiles_usr pwd)

## Exit if the script was not launched by root or through sudo
if [ "$EUID" -ne 0 ]; then
  echo "The script needs to run as root" && exit 1
fi

## Make all scripts executable
for file in "$dotfiles_wd"/install.d/*.sh; do
  chmod +x "$file"
done

## Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install gum
brew install gum

## remove env variables
unset dotfiles_usr
unset dotfiles_usr_home
unset dotfiles_wd

## Set back to non-verbose output
