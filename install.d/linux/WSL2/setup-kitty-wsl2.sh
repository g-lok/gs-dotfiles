#!/usr/bin/env bash
## Setup Kitty in WSL2 for GUI forwarding
## Best practice: Run Kitty directly in WSL2 with WSLg (Windows 11)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WSL2_DIR="$SCRIPT_DIR"

echo "=========================================="
echo "Kitty WSL2 GUI Setup"
echo "=========================================="

# ==========================================
# Step 1: Detect Windows Version
# ==========================================

echo ""
echo "=== Detecting Windows Version ==="

# Check if Windows 11 (has WSLg built-in)
WSL_VERSION=$(wsl.exe --status 2>/dev/null | head -5 || echo "unknown")
echo "WSL Status:"
wsl.exe --status 2>/dev/null || true

# Check if we have WSLg (Windows 11 22H2+)
if grep -qi "microsoft" /proc/version 2>/dev/null; then
    echo "Running on Microsoft WSL"
fi

# ==========================================
# Step 2: Install Dependencies
# ==========================================

echo ""
echo "=== Installing Dependencies ==="

# Install kitty via homebrew if not present
if ! command -v kitty &>/dev/null; then
    echo "Installing Kitty via Homebrew..."
    brew install kitty
fi

# Install recommended dependencies for better GUI support
echo "Installing GUI dependencies..."
sudo apt install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libx11-6 \
    libxcb1 \
    libxrandr2 \
    libxkbcommon0 \
    libfontconfig1 \
    libxdot4 \
    2>/dev/null || true

# Install emoji font support
sudo apt install -y fonts-noto-color-emoji 2>/dev/null || true

# ==========================================
# Step 3: Configure DISPLAY
# ==========================================

echo ""
echo "=== Configuring DISPLAY ==="

# Create or update shellrc for DISPLAY
DISPLAY_SETUP='
# WSL2 GUI Display Configuration
# Windows 11 with WSLg: Uses Wayland (usually auto-detected)
# Windows 10 with X server: Set DISPLAY manually

# Auto-detect WSLg (Windows 11 22H2+)
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
    # Try WSLg first (Wayland)
    if [ -S "/mnt/wslg/runtime-wayland-0" ]; then
        export WAYLAND_DISPLAY=wayland-0
        export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
    else
        # Fall back to X server (Windows 10 or manual X server)
        export DISPLAY=$(awk "/nameserver / {print \$2; exit}" /etc/resolv.conf 2>/dev/null):0
        export LIBGL_ALWAYS_INDIRECT=0
    fi
fi

# Disable Wayland in Kitty (use X11 for better compatibility)
export KITTY_DISABLE_WAYLAND=1
'

# Add to shellrc if not present
SHELLRC="$HOME/.shellrc"
if [ -f "$SHELLRC" ]; then
    if ! grep -q "KITTY_DISABLE_WAYLAND" "$SHELLRC" 2>/dev/null; then
        echo "$DISPLAY_SETUP" >> "$SHELLRC"
        echo "Added DISPLAY config to $SHELLRC"
    fi
fi

# Also check .zshrc as fallback
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if ! grep -q "KITTY_DISABLE_WAYLAND" "$ZSHRC" 2>/dev/null; then
        echo "$DISPLAY_SETUP" >> "$ZSHRC"
        echo "Added DISPLAY config to $ZSHRC"
    fi
fi

echo "DISPLAY configuration added to shell startup files"

# ==========================================
# Step 4: Test Kitty
# ==========================================

echo ""
echo "=== Testing Kitty ==="

echo "To test Kitty, run:"
echo "  kitty &"
echo ""
echo "If you get GLFW errors, try:"
echo "  KITTY_DISABLE_WAYLAND=1 kitty"

# ==========================================
# Step 5: Create Windows Start Menu Shortcut
# ==========================================

echo ""
echo "=== Creating Windows Start Menu Shortcut ==="

# Create PowerShell script to generate shortcut
SHORTCUT_SCRIPT="$HOME/create_kitty_shortcut.ps1"

cat > "$SHORTCUT_SCRIPT" << 'PSEOF'
# Create Kitty Shortcut for Windows Start Menu
# Run this in PowerShell as Administrator

$wsshell = New-Object -ComObject WScript.Shell
$desktop = $wsshell.SpecialFolders("Desktop")

# Create shortcut on Desktop
$shortcut = $wsshell.CreateShortcut("$desktop\Kitty WSL2.lnk")
$shortcut.TargetPath = "wsl.exe"
$shortcut.Arguments = "-d Ubuntu kitty"
$shortcut.WorkingDirectory = "$env:USERPROFILE"
$shortcut.Description = "Kitty Terminal in WSL2"
$shortcut.Save()

# Also create in Start Menu
$startMenu = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
$shortcut2 = $wsshell.CreateShortcut("$startMenu\Kitty WSL2.lnk")
$shortcut2.TargetPath = "wsl.exe"
$shortcut2.Arguments = "-d Ubuntu kitty"
$shortcut2.WorkingDirectory = "$env:USERPROFILE"
$shortcut2.Description = "Kitty Terminal in WSL2"
$shortcut2.Save()

Write-Host "Shortcuts created successfully!"
Write-Host "  Desktop: $desktop\Kitty WSL2.lnk"
Write-Host "  Start Menu: $startMenu\Kitty WSL2.lnk"
PSEOF

echo "Created: $SHORTCUT_SCRIPT"
echo ""
echo "To create Windows Start Menu shortcut:"
echo "  1. Run this command in PowerShell (as admin or user):"
echo "     powershell -ExecutionPolicy Bypass -File $SHORTCUT_SCRIPT"
echo ""
echo "  2. Or manually create a shortcut with:"
echo "     Target: wsl.exe"
echo "     Arguments: -d Ubuntu kitty"

# ==========================================
# Step 6: Install Kitty Shell Integration
# ==========================================

echo ""
echo "=== Installing Kitty Shell Integration ==="

# Install Kitty shell integration
if [ ! -d "$HOME/.local/kitty" ]; then
    echo "Installing Kitty shell integration..."
    mkdir -p "$HOME/.local/kitty"
    curl -L https://sw.kovidgoyal.net/kitty/shell-integration/install-shell.sh | bash -s -- "$HOME/.local/kitty"
fi

# Add to .zshrc if not present
KITTY_INTEGRATION='
# Kitty shell integration
if [ -f "$HOME/.local/kitty/boot.zsh" ]; then
    export KITTY_SHELL_INTEGRATION=enabled
    source "$HOME/.local/kitty/boot.zsh"
fi
'

if ! grep -q "kitty/boot.zsh" "$HOME/.zshrc" 2>/dev/null; then
    echo "$KITTY_INTEGRATION" >> "$HOME/.zshrc"
    echo "Added Kitty shell integration to .zshrc"
fi

echo ""
echo "=========================================="
echo "Kitty WSL2 Setup Complete!"
echo "=========================================="
echo ""
echo "To launch Kitty from Windows:"
echo "  1. Use the Start Menu shortcut (after running PowerShell script above)"
echo "  2. Or run: wsl.exe -d Ubuntu kitty"
echo "  3. Or run: kitty (from WSL2 terminal)"
echo ""
echo "Key configurations:"
echo "  - KITTY_DISABLE_WAYLAND=1 (forces X11 mode)"
echo "  - DISPLAY auto-configured for WSLg or X server"
echo "  - Shell integration enabled"
