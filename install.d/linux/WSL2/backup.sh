#!/usr/bin/env bash
## Backup current WSL2 environment state
## Run this to update the backup files before reinstalling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WSL2_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "Backing up WSL2 environment"
echo "=========================================="

# Homebrew packages
echo "Backing up Homebrew packages..."
cd "$WSL2_DIR"
if command -v brew &>/dev/null; then
	brew bundle dump --force --file=Brewfile-wsl2 2>/dev/null || true
fi

# Dotfiles (from ~/dotfiles if stowed)
if [ -d "$HOME/dotfiles" ]; then
	echo "Backing up ~/dotfiles/ (stow source)..."
	rsync -a "$HOME/dotfiles/" "$WSL2_DIR/dotfiles/"
fi

# Oh My Zsh config
echo "Backing up Oh My Zsh..."
mkdir -p "$WSL2_DIR/ohmyzsh"
cp -r "$HOME/.oh-my-zsh" "$WSL2_DIR/ohmyzsh/" 2>/dev/null || true
cp "$HOME/.zshrc" "$WSL2_DIR/ohmyzsh/" 2>/dev/null || true

echo ""
echo "Backup complete!"
