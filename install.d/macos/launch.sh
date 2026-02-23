#!/usr/bin/env bash

gum spin --spinner moon --title "Installing HomeBrew Apps..." -- sleep 2
source "$GSDOT_SCRIPTS/macos/yos-packages.sh"
# gum spin --spinner moon --title "Installing Oh-My-Zsh..." -- "$GSDOT_SCRIPTS/zsh.sh"
# gum spin --spinner moon --title "Installing Oh-My-Zsh..." -- sleep 2
source "$GSDOT_SCRIPTS/zsh.sh" >/dev/null 2>&1
# gum spin --spinner moon --title "Install Lazyvim..." -- "$GSDOT_SCRIPTS/install-lazyvim.sh"
# gum spin --spinner moon --title "Installing Lazyvimim..." -- sleep 2
source "$GSDOT_SCRIPTS/install-lazyvim.sh" >/dev/null 2>&1
# gum spin --spinner moon --title "Configuring System Settings..." -- "$GSDOT_SCRIPTS/macos/yos-main-configs.sh"
# gum spin --spinner moon --title "Configuring main MacOS settings..." -- sleep 2
source "$GSDOT_SCRIPTS/macos/yos-main-configs.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configure Dock Settings" -- "$GSDOT_SCRIPTS/macos/yos-dock.sh"
# gum spin --spinner moon --title "Configuring Dock settings..." -- sleep 2
# source "$GSDOT_SCRIPTS/macos/yos-dock.sh"
gum spin --spinner moon --title "Configure Peripheral Settings..." -- "$GSDOT_SCRIPTS/macos/yos-peripherals.sh"
# gum spin --spinner moon --title "Configuring peripherals..." -- sleep 2
# source "$SCRIPTS_DIR/macos/yos-peripherals.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configuring screenshots..." -- "$GSDOT_SCRIPTS/macos/yos-screenshots.sh"
# gum spin --spinner moon --title "Configuring screenshots..." -- sleep 2
# source "$SCRIPTS_DIR/macos/yos-screenshots.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Installing theme..." -- "$GSDOT_SCRIPTS/themes.sh"
# gum spin --spinner moon --title "Configuring Dotfiles..." -- "$GSDOT_SCRIPTS/dotfiles/dotfiles.sh"
# gum spin --spinner moon --title "Configuring dotfiles..." -- sleep 2
"$GSDOT_SCRIPTS/dotfiles/dotfiles.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configuring Git..." -- "$GSDOT_SCRIPTS/git.sh"
# gum spin --spinner moon --title "Configuring git..." -- sleep 2
# source "$SCRIPTS_DIR/git.sh" >/dev/null 2>&1
