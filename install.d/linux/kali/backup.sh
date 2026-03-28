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

# Session context files (AI session context)
if [ -d "$HOME/.session" ]; then
	echo "Backing up session context files..."
	mkdir -p "$KALI_DIR/session"
	cp -r "$HOME/.session"/*.md "$KALI_DIR/session/" 2>/dev/null || true
fi

# Update Kitty SESSION.md redirect to point to session files
echo "Updating Kitty SESSION.md redirect..."
mkdir -p "$KALI_DIR/dotfiles/kitty-linux/.config/kitty"
cat > "$KALI_DIR/dotfiles/kitty-linux/.config/kitty/SESSION.md" << 'EOF'
# Session Context Moved

Session context files have moved to **`~/.session/`**

| File | Purpose |
|------|---------|
| SESSION.md | AI onboarding (read this first) |
| REFERENCE.md | Detailed reference, keymaps, TODOs, **Active Projects** |
| chat_history.md | Conversation history |

Run: `ls -la ~/.session/`

**For project-specific work**: See "Active Projects" section in REFERENCE.md to track where we're working.
EOF

# Backup Kitty wrapper script
if [ -f "$HOME/.local/bin/kitty" ]; then
	echo "Backing up Kitty wrapper..."
	mkdir -p "$KALI_DIR/dotfiles/kitty-linux/.local/bin"
	cp "$HOME/.local/bin/kitty" "$KALI_DIR/dotfiles/kitty-linux/.local/bin/"
fi

# Backup ~/dotfiles/ (stow source) - backs up the actual stow-able configs
# First copy any items that exist in backup but not in ~/dotfiles
if [ -d "$HOME/dotfiles" ]; then
	echo "Backing up ~/dotfiles/ (stow source)..."
	# Sync from ~/dotfiles to backup (preserves items in backup not in ~/dotfiles)
	rsync -a "$HOME/dotfiles/" "$KALI_DIR/dotfiles/"
fi

echo ""
echo "Backup complete!"
ls -lh "$KALI_DIR"/*.dconf "$KALI_DIR"/*.list "$KALI_DIR"/*.tar.gz 2>/dev/null
