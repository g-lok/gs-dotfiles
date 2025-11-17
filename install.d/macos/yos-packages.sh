#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

## Determine if we're on Intel or Arm64
if [[ "$(uname -m)" == "arm64" ]]; then
  CHIPSET="ARM64"
else
  CHIPSET="INTEL"
fi

## Function to install Furnace
install_furnace() {
  OWNER="tildearrow"
  REPO="furnace"
  if [[ $CHIPSET == "ARM64" ]]; then
    ASSET_NAME="mac-arm64"
  else
    ASSET_NAME="mac-Intel"
  fi

  ## Fetch the latest release and extract the browser_download_url for the macOS asset
  curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest" |
    jq -r ".assets[] | select(.name | contains(\"$ASSET_NAME\")) | .browser_download_url" |
    xargs -I {} curl -L -o "$SCRIPT_DIR/furnace_latest_mac_release.dmg" {}

  printf "$HOMEBREW_PASSWORD" | hdiutil attach -stdinpass "$SCRIPT_DIR/furnace_latest_mac_release.dmg"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/Furnace.app" "/Applications/"
  mkdir -p "$HOME/Documents/Furnace"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp "/Volumes/Furnace/manual.pdf" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/demos" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/instruments" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/wavetables" "$HOME/Documents/Furnace/"
  rm "$SCRIPT_DIR/furnace_latest_mac_release.dmg"
}

## Function to install optional toolsets
install_optional_tools() {
  echo "install_optional_tools: $1"
  case "$1" in
  "Developer_Tools")
    brew bundle install --file "$SCRIPT_DIR/Brewfile-dev"
    "$SCRIPT_DIR/../select-mise-languages.sh"
    ;;
  "DevOps_Tools")
    brew bundle install --file "$SCRIPT_DIR/Brewfile-devops"
    ;;
  "Artist_Tools")
    brew bundle install --file "$SCRIPT_DIR/Brewfile-artist-apps"
    install_furnace
    ;;
  *)
    echo "$optional is not a valid toolset"
    ;;
  esac
}

brew bundle install --file "$SCRIPT_DIR/Brewfile-terminal-apps"
brew bundle install --file "$SCRIPT_DIR/Brewfile-desktop-apps"
brew bundle install --file "$SCRIPT_DIR/Brewfile-nerdfonts"

## Install optional packages
if ((${#HOMEBREW_APP_CHOICES[@]} != 0)); then
  for optionals in "${HOMEBREW_APP_CHOICES[@]}"; do
    install_optional_tools "$optionals"
  done
fi

brew cleanup
