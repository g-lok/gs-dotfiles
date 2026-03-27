#!/usr/bin/env bash
## Backup current environment state
## Run this to update the backup files before reinstalling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KALI_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "Backing up current environment"
echo "=========================================="

# GNOME settings
echo "Backing up GNOME settings..."
dconf dump / >"$KALI_DIR/settings.dconf"

# APT packages
echo "Backing up APT packages..."
dpkg-query -W -f='${Package}\t${Status}\n' | grep install | awk '{print $1}' | sort >"$KALI_DIR/apt-packages.list"

# Snap packages
echo "Backing up Snap packages..."
snap list 2>/dev/null | tail -n +2 >"$KALI_DIR/snap-list.txt"

# GNOME extensions
echo "Backing up GNOME extensions..."
gnome-extensions list --enabled >/tmp/enabled_extensions.txt

# GNOME extension settings (per-extension)
mkdir -p /tmp/gnome-extensions-backup
for ext in $(cat /tmp/enabled_extensions.txt); do
	ext_name=$(basename "$ext")
	dconf dump "/org/gnome/shell/extensions/$ext_name/" >"/tmp/gnome-extensions-backup/$ext_name.ini" 2>/dev/null || true
done
cd /tmp/gnome-extensions-backup
tar -czf "$KALI_DIR/gnome-extensions-backup.tar.gz" . 2>/dev/null || true

# Oh My Zsh
echo "Backing up Oh My Zsh..."
cd "$HOME"
tar -czf "$KALI_DIR/ohmyzsh.tar.gz" .oh-my-zsh .zshrc 2>/dev/null || true

# Kitty config (if exists)
if [ -d "$HOME/.config/kitty" ]; then
	echo "Backing up Kitty config..."
	cp -r "$HOME/.config/kitty" "$KALI_DIR/dotfiles/kitty-linux/.config/"
fi

# Zellij config (if exists)
if [ -d "$HOME/.config/zellij" ]; then
	echo "Backing up Zellij config..."
	cp "$HOME/.config/zellij/config.kdl" "$KALI_DIR/dotfiles/zellij-linux/.config/zellij/" 2>/dev/null || true
fi

echo ""
echo "Backup complete!"
ls -lh "$KALI_DIR"/*.dconf "$KALI_DIR"/*.list "$KALI_DIR"/*.tar.gz 2>/dev/null
