#!/usr/bin/env bash

## Install Selected Creativity Apps
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
    xargs -I {} curl -L -o "$SCRIPTS_DIR/furnace_latest_mac_release.dmg" {}

  printf "$HOMEBREW_PASSWORD" | hdiutil attach -stdinpass "$SCRIPTS_DIR/furnace_latest_mac_release.dmg"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/Furnace.app" "/Applications/"
  mkdir -p "$HOME/Documents/Furnace"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp "/Volumes/Furnace/manual.pdf" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/demos" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/instruments" "$HOME/Documents/Furnace/"
  printf "$HOMEBREW_PASSWORD" | sudo -S cp -R "/Volumes/Furnace/wavetables" "$HOME/Documents/Furnace/"
  rm "$SCRIPTS_DIR/furnace_latest_mac_release.dmg"
}

if [[ ${#CREATIVE_SELECTIONS[@]} -gt 0 ]]; then
  for option in "${CREATIVE_SELECTIONS[@]}"; do
    case ${option} in
    Audacity)
      brew install --cask audacity # Audio editor
      ;;
    Gimp)
      brew install --cask gimp # Image editor
      ;;
    Krita)
      brew install --cask krita # Painting program
      ;;
    Blender)
      brew install --cask blender # Powerful 3D CG Suite
      ;;
    Furnace)
      install_furnace
      ;;
    VCV)
      brew install --cask vcv-rack
      ;;
    esac
  done
fi
