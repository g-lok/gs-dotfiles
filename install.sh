#!/usr/bin/env bash

# set -e

## Personal set-up scripts for Ubuntu Linux and OSX
## Heavily inspired (*ahem* copied) by Juxtaposed, Omakub, too many to remember

## Print Ascii logo with color.
ascii_art='
  _______/\        ________          __    _____.__.__
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/
'

## Define the color gradient (shades of cyan and blue)
colors=(
  '\033[38;5;81m' # Cyan
  '\033[38;5;75m' # Light Blue
  '\033[38;5;69m' # Sky Blue
  '\033[38;5;63m' # Dodger Blue
  '\033[38;5;57m' # Deep Sky Blue
  '\033[38;5;51m' # Cornflower Blue
  '\033[38;5;45m' # Royal Blue
)
#
# ## Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"
#
# ## Print each line with the corresponding color
for i in "${!lines[@]}"; do
  color_index=$((i % ${#colors[@]}))
  echo -e "${colors[color_index]}${lines[i]}"
done

echo -e "\nBegin installation (or abort with ctrl+c)..."

## Make sure sudo is already cached before using gum spinner or anything that will interfere with the scripts
sudo --validate

## Export the current directory as env variable
export GS_DOTFILES_PATH=$(dirname "$(readlink -f "$0")")

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
    echo "Command Line Tools are not installed."
    echo "You will be prompted to install Xcode command line tools."
    echo "Please Install Xcode command line tools before resuming."
    xcode-select --install
  fi
  ;;
*)
  echo "This script is running on an unknown operating system: $OS"
  # Add commands for other systems or error handling
  exit 0
  ;;
esac

## Make all scripts executable
for file in $GS_DOTFILES_PATH/install.d/*.sh; do
  chmod +x "$file"
done

## Install Homebrew
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
else
  echo "Homebrew is already installed. Updating..."
  brew update >/dev/null
  brew upgrade >/dev/null
fi

## Temporarily load Homebrew's config and PATH and whatnot
command -v brew >/dev/null || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH" >/dev/null
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

NAME=$(gum input --prompt "Please enter full name: ")
EMAIL=$(gum input --prompt "Please enter email: ")
HOMEBREW_PASSWORD=$(gum input --password --prompt "Please enter password: ")
export NAME
export EMAIL
export HOMEBREW_PASSWORD
## STOP ASKING ME FOR SUDO!
export SUDO_ASKPASS="$GS_DOTFILES_PATH/install.d/returnpass.sh"
export CI=true

## Create directories under home
echo "creating directories"
source "$GS_DOTFILES_PATH/install.d/directories.sh"
echo "directories created"

## Get installation choices
declare -a OPTIONAL_APPS
declare -a APP_CATEGORIES
OPTIONAL_APPS=("Developer_Tools" "DevOps_Tools" "Artist_Tools")
export APP_CATEGORIES=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --header "Select optional application categories to install.")

## I shouldn't have to do this,
## but gum choose up there isn't creating an array,
## but a newline delimited string.
readarray -t HOMEBREW_APP_CHOICES <<<"$APP_CATEGORIES"
export HOMEBREW_APP_CHOICES

## Run installation scripts based on OS
gum style \
  --foreground="$FOREGROUND" --background="$BACKGROUND" \
  --border-foreground="$BORDER_FOREGROUND" \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Running Installation and Configuration Scripts"

case $SCRIPT_OS in
"MacOS")
  gum spin --spinner moon --title "Installing HomeBrew Apps..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/macos/yos-packages.sh" gum spin --spinner moon --title "Install Oh-My-Zsh" -- "$GS_DOTFILES_PATH/install.d/zsh.sh"
  gum spin --spinner moon --title "Installing Oh-My-Zsh..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/zsh.sh"
  # gum spin --spinner moon --title "Install Lazyvim" -- "$GS_DOTFILES_PATH/install.d/install-lazyvim.sh"
  gum spin --spinner moon --title "Installing LazyVim..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/install-lazyvim.sh"
  # gum spin --spinner moon --title "Configure System Settings" -- "$GS_DOTFILES_PATH/install.d/macos/yos-main-configs.sh"
  gum spin --spinner moon --title "Configuring main MacOS settings..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/macos/yos-main-configs.sh"
  # gum spin --spinner moon --title "Configure Dock Settings" -- "$GS_DOTFILES_PATH/install.d/macos/yos-dock.sh"
  gum spin --spinner moon --title "Configuring MacOS Dock settings..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/macos/yos-dock.sh"
  # gum spin --spinner moon --title "Configure Peripheral Settings" -- "$GS_DOTFILES_PATH/install.d/macos/yos-peripherals.sh"
  gum spin --spinner moon --title "Configuring peripherals..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/macos/yos-peripherals.sh"
  gum spin --spinner moon --title "Configuring screenshots..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/macos/yos-screenshots.sh"
  # gum spin --spinner moon --title "Stow Dotfiles." -- "$GS_DOTFILES_PATH/install.d/dotfiles/dotfiles.sh"
  gum spin --spinner moon --title "Configuring dotfiles..." -- sleep 2
  "$GS_DOTFILES_PATH/install.d/dotfiles/dotfiles.sh"
  # gum spin --spinner moon --title "Configure Git." -- "$GS_DOTFILES_PATH/install.d/git.sh"
  gum spin --spinner moon --title "Configuring git..." -- sleep 2
  source "$GS_DOTFILES_PATH/install.d/git.sh"
  ;;
*)
  echo "Unrecognized OS. Skipping installation and configuration."
  ;;
esac

## Setup gum environment variables
export FOREGROUND="#FF0"
export BACKGROUND="#0BB"
export BORDER_FOREGROUND="212"
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "GNU Stow Adopted existing configs to this repo." "Do you want to git restore to use this repo's configs?"
gum confirm && git restore . || echo "No git actions taken. Using adopted configs."

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
