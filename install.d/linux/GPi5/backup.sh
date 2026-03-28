#!/usr/bin/env bash
## Backup current GPi5 environment state
## Run this to update the backup files before reinstalling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GPI5_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "Backing up GPi5 environment"
echo "=========================================="

# APT packages
echo "Backing up APT packages..."
dpkg-query -W -f='${Package}\t${Status}\n' | grep install | awk '{print $1}' | sort >"$GPI5_DIR/apt-packages.list"

# Homebrew packages
echo "Backing up Homebrew packages..."
cd "$GPI5_DIR"
if command -v brew &>/dev/null; then
	brew bundle dump --force --file=Brewfile-gpi5 2>/dev/null || true
fi

# Dotfiles (from ~/dotfiles if stowed)
if [ -d "$HOME/dotfiles" ]; then
	echo "Backing up ~/dotfiles/ (stow source)..."
	rsync -a "$HOME/dotfiles/" "$GPI5_DIR/dotfiles/"
fi

# Oh My Zsh config
echo "Backing up Oh My Zsh..."
mkdir -p "$GPI5_DIR/ohmyzsh"
cp -r "$HOME/.oh-my-zsh" "$GPI5_DIR/ohmyzsh/" 2>/dev/null || true
cp "$HOME/.zshrc" "$GPI5_DIR/ohmyzsh/" 2>/dev/null || true

echo ""
echo "Backup complete!"
