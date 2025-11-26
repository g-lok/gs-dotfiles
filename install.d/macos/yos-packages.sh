#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

## Function to install optional toolsets
install_optional_tools() {
  case "$1" in
  "Developer_Tools")
    brew bundle install --file "$SCRIPTS_DIR/macos/Brewfile-dev"
    source "$SCRIPTS_DIR/install_mise_languages.sh"
    source "$SCRIPTS_DIR/macos/yos-packages-devops.sh"
    # source "$SCRIPTS_DIR/install_dbs.sh"
    ;;
  "Creative_Tools")
    source "$SCRIPTS_DIR/macos/yos-packages-creative.sh"
    ;;
  *)
    echo "$1 is not a valid toolset"
    ;;
  esac
}

brew bundle install --file "$SCRIPTS_DIR/macos/Brewfile-terminal-apps"
brew bundle install --file "$SCRIPTS_DIR/macos/Brewfile-desktop-apps"
source "$SCRIPTS_DIR/macos/yos_optional_desktop_apps.sh"
brew bundle install --file "$SCRIPTS_DIR/macos/Brewfile-nerdfonts"

## Install optional packages
if [[ ${#HOMEBREW_APP_CHOICES[@]} -gt 0 ]]; then
  for optionals in "${HOMEBREW_APP_CHOICES[@]}"; do
    install_optional_tools "$optionals"
  done
fi

## Brew cleanup
brew doctor
brew cleanup
