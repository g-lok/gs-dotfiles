#!/usr/bin/env bash
## Install script for WSL2 (Windows Subsystem for Linux)
## Headless environment - no GUI/Desktop

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WSL2_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "WSL2 Headless Environment Installer"
echo "=========================================="

## ==========================================
## Phase 1: Package Managers
## ==========================================

echo ""
echo "=== Phase 1: Package Managers ==="

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
echo "Installing Homebrew packages..."
cd "$WSL2_DIR"
if [ -f "Brewfile-wsl2" ]; then
	brew bundle install --file=Brewfile-wsl2 || true
fi

## ==========================================
## Phase 2: Oh My Zsh (must be before dotfiles)
## ==========================================

echo ""
echo "=== Phase 2: Oh My Zsh ==="

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended || true
fi

## ==========================================
## Phase 3: Dotfiles
## ==========================================

echo ""
echo "=== Phase 3: Dotfiles ==="

# Run dotfiles stow (fresh mode - use pre-configured versions)
cd "$WSL2_DIR/dotfiles"
./dotfiles.sh --mode=fresh

## ==========================================
## Phase 4: Oh My Zsh plugins
## ==========================================

echo ""
echo "=== Phase 4: Oh My Zsh Plugins ==="

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
## Phase 5: mise global tools
## ==========================================

echo ""
echo "=== Phase 5: mise Global Tools ==="

if command -v mise &>/dev/null; then
	echo "Installing mise global tools..."
	# Install tools from global config
	mise install
	# Trust global config
	mise trust --yes
	# Upgrade all tools to latest
	mise upgrade --all
fi

## ==========================================
## Phase 6: Kitty WSL2 GUI Setup
## ==========================================

echo ""
echo "=== Phase 6: Kitty WSL2 GUI Setup ==="

# Install GUI dependencies
echo "Installing GUI dependencies..."
sudo apt install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libx11-6 \
    libxcb1 \
    libxrandr2 \
    libxkbcommon0 \
    libfontconfig1 \
    fonts-noto-color-emoji \
    2>/dev/null || true

# Install Kitty (official binary installer - latest version)
# See: https://sw.kovidgoyal.net/kitty/binary/
if [ ! -d "$HOME/.local/kitty.app" ]; then
    echo "Installing Kitty (official binary)..."
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
fi

# Create symlinks for kitty
if [ ! -f "$HOME/.local/bin/kitty" ]; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
    ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"
fi

# Install Kitty shell integration
if [ ! -d "$HOME/.local/kitty" ]; then
	echo "Installing Kitty shell integration..."
	mkdir -p "$HOME/.local/kitty"
	curl -L https://sw.kovidgoyal.net/kitty/shell-integration/install-shell.sh | bash -s -- "$HOME/.local/kitty"
fi

# Add Kitty integration + DISPLAY config to .zshrc
KITTY_SETUP='
# WSL2 GUI Display Configuration
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
    if [ -S "/mnt/wslg/runtime-wayland-0" ]; then
        export WAYLAND_DISPLAY=wayland-0
        export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
    else
        export DISPLAY=$(awk "/nameserver / {print \$2; exit}" /etc/resolv.conf 2>/dev/null):0
        export LIBGL_ALWAYS_INDIRECT=0
    fi
fi
export KITTY_DISABLE_WAYLAND=1

# Add kitty to PATH (official binary)
export PATH="$HOME/.local/bin:$PATH"

# Kitty shell integration
if [ -f "$HOME/.local/kitty/boot.zsh" ]; then
    export KITTY_SHELL_INTEGRATION=enabled
    source "$HOME/.local/kitty/boot.zsh"
fi
'

if ! grep -q "KITTY_DISABLE_WAYLAND" "$HOME/.zshrc" 2>/dev/null; then
	echo "Adding Kitty + DISPLAY config to .zshrc..."
	echo "$KITTY_SETUP" >> "$HOME/.zshrc"
fi

echo "Kitty GUI setup complete!"

## ==========================================
## Done
## ==========================================

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Start a new shell to apply changes."
