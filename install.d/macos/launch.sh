#!/usr/bin/env bash

gum spin --spinner moon --title "Installing HomeBrew Apps..." -- sleep 2
source "$SCRIPTS_DIR/macos/yos-packages.sh"
gum spin --spinner moon --title "Installing Oh-My-Zsh..." -- "$SCRIPTS_DIR/zsh.sh"
# gum spin --spinner moon --title "Installing Oh-My-Zsh..." -- sleep 2
# source "$SCRIPTS_DIR/zsh.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Install Lazyvim..." -- "$SCRIPTS_DIR/install-lazyvim.sh"
# gum spin --spinner moon --title "Installing Lazyvimim..." -- sleep 2
# source "$SCRIPTS_DIR/install-lazyvim.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configuring System Settings..." -- "$SCRIPTS_DIR/macos/yos-main-configs.sh"
# gum spin --spinner moon --title "Configuring main MacOS settings..." -- sleep 2
# source "$SCRIPTS_DIR/macos/yos-main-configs.sh" >/dev/null 2>&1
# gum spin --spinner moon --title "Configure Dock Settings" -- "$SCRIPTS_DIR/macos/yos-dock.sh"
gum spin --spinner moon --title "Configuring Dock settings..." -- sleep 2
source "$SCRIPTS_DIR/macos/yos-dock.sh"
gum spin --spinner moon --title "Configure Peripheral Settings..." -- "$SCRIPTS_DIR/macos/yos-peripherals.sh"
# gum spin --spinner moon --title "Configuring peripherals..." -- sleep 2
# source "$SCRIPTS_DIR/macos/yos-peripherals.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configuring screenshots..." -- "$SCRIPTS_DIR/macos/yos-screenshots.sh"
# gum spin --spinner moon --title "Configuring screenshots..." -- sleep 2
# source "$SCRIPTS_DIR/macos/yos-screenshots.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Installing theme..." -- "$SCRIPTS_DIR/themes.sh"
gum spin --spinner moon --title "Configuring Dotfiles..." -- "$SCRIPTS_DIR/dotfiles/dotfiles.sh"
# gum spin --spinner moon --title "Configuring dotfiles..." -- sleep 2
# "$SCRIPTS_DIR/dotfiles/dotfiles.sh" >/dev/null 2>&1
gum spin --spinner moon --title "Configuring Git..." -- "$SCRIPTS_DIR/git.sh"
# gum spin --spinner moon --title "Configuring git..." -- sleep 2
# source "$SCRIPTS_DIR/git.sh" >/dev/null 2>&1
