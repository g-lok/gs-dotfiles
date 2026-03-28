#!/usr/bin/env bash
## Quick sync for Kali - pull latest dotfiles without full install

set -e

GSDOTFILES_REPO="${GSDOTFILES_REPO:-https://github.com/your/gs-dotfiles.git}"
GSDOTFILES_DIR="${HOME}/gs-dotfiles"

echo "=========================================="
echo "Quick Sync: Kali Dotfiles"
echo "=========================================="

if [ -d "$GSDOTFILES_DIR/.git" ]; then
	cd "$GSDOTFILES_DIR"
	git pull
else
	git clone "$GSDOTFILES_REPO" "$GSDOTFILES_DIR"
fi

cd "$GSDOTFILES_DIR/install.d/linux/kali/dotfiles"

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
