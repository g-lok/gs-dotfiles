#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

## Function to install optional toolsets
install_optional_tools() {
  case "$1" in
  "Developer_Tools")
    brew bundle install --file "$GSDOT_SCRIPTS/macos/Brewfile-dev"
    source "$GSDOT_SCRIPTS/install_mise_languages.sh"
    source "$GSDOT_SCRIPTS/macos/yos_packages-devops.sh"
    # source "$SCRIPTS_DIR/install_dbs.sh"
    ;;
  "Creative_Tools")
    source "$GSDOT_SCRIPTS/macos/yos_packages_creative.sh"
    ;;
  *)
    echo "$1 is not a valid toolset"
    ;;
  esac
}

brew bundle install --file "$GSDOT_SCRIPTS/macos/Brewfile-terminal-apps"
brew bundle install --file "$GSDOT_SCRIPTS/macos/Brewfile-desktop-apps"
source "$GSDOT_SCRIPTS/macos/yos_optional_desktop_apps.sh"
brew bundle install --file "$GSDOT_SCRIPTS/macos/Brewfile-nerdfonts"

## Install optional packages
if [[ ${#HOMEBREW_APP_CHOICES[@]} -gt 0 ]]; then
  for optionals in "${HOMEBREW_APP_CHOICES[@]}"; do
    install_optional_tools "$optionals"
  done
fi

## Brew cleanup
brew doctor
brew cleanup
