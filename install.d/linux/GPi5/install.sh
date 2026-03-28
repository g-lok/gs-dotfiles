#!/usr/bin/env bash
## Install script for Raspberry Pi 5 (GPi5)
## Headless server environment - no GUI/Desktop

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GPI5_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "GPi5 Headless Server Installer"
echo "=========================================="

## ==========================================
## Phase 1: System Packages (apt)
## ==========================================

echo ""
echo "=== Phase 1: System Packages ==="

# Update
sudo apt update

# Install base packages
echo "Installing system packages..."
sudo apt install -y \
	build-essential \
	curl \
	wget \
	git \
	vim \
	htop \
	jq \
	rsync \
	gnupg \
	software-properties-common \
	apt-transport-https \
	ca-certificates

## ==========================================
## Phase 2: Homebrew
## ==========================================

echo ""
echo "=== Phase 2: Homebrew ==="

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
echo "Installing Homebrew packages..."
cd "$GPI5_DIR"
if [ -f "Brewfile-gpi5" ]; then
	brew bundle install --file=Brewfile-gpi5 || true
fi

## ==========================================
## Phase 3: Oh My Zsh (must be before dotfiles)
## ==========================================

echo ""
echo "=== Phase 3: Oh My Zsh ==="

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended || true
fi

## ==========================================
## Phase 4: Dotfiles
## ==========================================

echo ""
echo "=== Phase 4: Dotfiles ==="

# Run dotfiles stow (fresh mode - use pre-configured versions)
cd "$GPI5_DIR/dotfiles"
./dotfiles.sh --mode=fresh

## ==========================================
## Phase 5: Oh My Zsh plugins
## ==========================================

echo ""
echo "=== Phase 5: Oh My Zsh Plugins ==="

# Install zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	echo "Installing zsh-autosuggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
	echo "Installing zsh-syntax-highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# Install zsh-completions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
	echo "Installing zsh-completions..."
	git clone https://github.com/zsh-users/zsh-completions "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

## ==========================================
## Phase 6: mise global tools
## ==========================================

echo ""
echo "=== Phase 6: mise Global Tools ==="

if command -v mise &>/dev/null; then
	echo "Installing mise global tools..."
	mise install
	mise trust --yes
	mise upgrade --all
fi

## ==========================================
## Done
## ==========================================

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Start a new shell to apply changes."
