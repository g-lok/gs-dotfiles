#!/usr/bin/env bash
## Quick sync for GPi5 - pull latest dotfiles without full install
## Run on remote server to sync environment

set -e

GSDOTFILES_REPO="${GSDOTFILES_REPO:-https://github.com/your/gs-dotfiles.git}"
GSDOTFILES_DIR="${HOME}/gs-dotfiles"

echo "=========================================="
echo "Quick Sync: GPi5 Dotfiles"
echo "=========================================="

# Clone or update gs-dotfiles
if [ -d "$GSDOTFILES_DIR/.git" ]; then
	echo "Updating gs-dotfiles..."
	cd "$GSDOTFILES_DIR"
	git pull
else
	echo "Cloning gs-dotfiles..."
	git clone "$GSDOTFILES_REPO" "$GSDOTFILES_DIR"
fi

# Sync dotfiles
echo "Syncing dotfiles..."
cd "$GSDOTFILES_DIR/install.d/linux/GPi5/dotfiles"

# Run stow for each config
for dir in */; do
	config="${dir%/}"
	if [ -d "$config/.config" ] || [ -f "$config/.zshrc" ]; then
		echo "  Stowing: $config"
		stow --target="$HOME" --restow "$config" 2>/dev/null || true
	fi
done

# Sync mise global tools
echo ""
echo "Syncing mise global tools..."
if command -v mise &>/dev/null; then
	mise install
	mise trust --yes
	mise upgrade --all
fi

echo ""
echo "Sync complete!"
