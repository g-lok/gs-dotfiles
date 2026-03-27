#!/usr/bin/env bash
## Master install script for Kali Linux environment
## Run this to recreate the full environment

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KALI_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "Kali Linux Environment Installer"
echo "=========================================="

## Check for root/sudo
if [[ $EUID -ne 0 ]]; then
	echo "Some steps require sudo. Enter password if prompted."
fi

## ==========================================
## Phase 1: Package Managers
## ==========================================

echo ""
echo "=== Phase 1: Package Managers ==="

# Enable 32-bit architecture (needed for some tools)
sudo dpkg --add-architecture i386 2>/dev/null || true

# Update
sudo apt update

# Install APT packages
echo "Installing APT packages..."
sudo apt install -y $(cat "$KALI_DIR/apt-packages.list" | grep -v '^#' | awk '{print $1}')

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
echo "Installing Homebrew packages..."
cd "$KALI_DIR"
if [ -f "Brewfile-kali" ]; then
	brew bundle install --file=Brewfile-kali || true
fi

# Install Snap packages
echo "Installing Snap packages..."
while IFS= read -r line; do
	if [[ -z "$line" ]] || [[ "$line" == Name* ]]; then continue; fi
	name=$(echo "$line" | awk '{print $1}')
	if ! snap list "$name" &>/dev/null; then
		sudo snap install $name --classic 2>/dev/null || true
	fi
done <"$KALI_DIR/snap-list.txt"

# Install Flatpak packages
echo "Installing Flatpak packages..."
flatpak install -y flathub md.obsidian.Obsidian 2>/dev/null || true

## ==========================================
## Phase 2: Build Tools & Source Installs
## ==========================================

echo ""
echo "=== Phase 2: Build Tools & Custom Installs ==="

# Install input-remapper
if [ -f "$KALI_DIR/input-remapper-2.2.0.deb" ]; then
	echo "Installing input-remapper..."
	sudo dpkg -i "$KALI_DIR/input-remapper-2.2.0.deb" || sudo apt install -f -y
fi

# Install Kitty (if not already installed)
if ! command -v kitty &>/dev/null; then
	echo "Installing Kitty..."
	"$KALI_DIR/dotfiles/kitty-install.sh"
fi

## ==========================================
## Phase 3: Dotfiles
## ==========================================

echo ""
echo "=== Phase 3: Dotfiles ==="

# Run dotfiles stow (fresh mode - use pre-configured versions)
cd "$KALI_DIR/dotfiles"
./dotfiles.sh --mode=fresh

## ==========================================
## Phase 4: GNOME Extensions
## ==========================================

echo ""
echo "=== Phase 4: GNOME Extensions ==="

# Install GNOME extensions from list
ENABLED_EXTENSIONS=(
	"drive-menu@gnome-shell-extensions.gcampax.github.com"
	"user-theme@gnome-shell-extensions.gcampax.github.com"
	"places-menu@gnome-shell-extensions.gcampax.github.com"
	"system-monitor@gnome-shell-extensions.gcampax.github.com"
	"tiling-assistant@leleat-on-github"
	"apps-menu@gnome-shell-extensions.gcampax.github.com"
	"tactile@lundal.io"
	"just-perfection-desktop@just-perfection"
	"blur-my-shell@aunetx"
	"space-bar@luchrioh"
	"undecorate@sun.wxg@gmail.com"
	"tophat@fflewddur.github.io"
	"AlphabeticalAppGrid@stuarthayhurst"
	"dash-to-dock@micxgx.gmail.com"
	"top-panel-vpnip@kali.org"
)

for ext in "${ENABLED_EXTENSIONS[@]}"; do
	if ! gnome-extensions list --enabled | grep -q "^$ext$"; then
		echo "Installing GNOME extension: $ext"
		gnome-extensions install "$ext" 2>/dev/null || true
		gnome-extensions enable "$ext" 2>/dev/null || true
	fi
done

# Restore GNOME extension settings from backup
if [ -f "$KALI_DIR/gnome-extensions-backup.tar.gz" ]; then
	echo "Restoring GNOME extension settings..."
	cd ~/.local/share/gnome-shell/extensions
	tar -xzf "$KALI_DIR/gnome-extensions-backup.tar.gz" 2>/dev/null || true
fi

## ==========================================
## Phase 5: GNOME Settings (LAST)
## ==========================================

echo ""
echo "=== Phase 5: GNOME Settings ==="

# Load dconf settings (must be LAST - after extensions installed)
if [ -f "$KALI_DIR/settings.dconf" ]; then
	echo "Loading GNOME settings..."
	dconf load / <"$KALI_DIR/settings.dconf"
fi

## ==========================================
## Phase 6: Oh My Zsh
## ==========================================

echo ""
echo "=== Phase 6: Oh My Zsh ==="

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Restore Oh My Zsh config
if [ -f "$KALI_DIR/ohmyzsh.tar.gz" ]; then
	echo "Restoring Oh My Zsh..."
	tar -xzf "$KALI_DIR/ohmyzsh.tar.gz" -C "$HOME/" 2>/dev/null || true
fi

## ==========================================
## Done
## ==========================================

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Some changes may require logout/login or restart."
echo ""
echo "To apply GNOME extension changes without logout:"
echo "  gnome-extensions disable <ext> && gnome-extensions enable <ext>"
