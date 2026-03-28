#!/usr/bin/env bash
## WSL2 Network Setup Script
## Run this to configure mirrored networking and firewall

set -e

echo "=========================================="
echo "WSL2 Network Setup"
echo "=========================================="

WSL_CONFIG="$HOME/.wslconfig"
WINDOWS_USERPROFILE=$(wslpath -u "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')")

echo ""
echo "=== Step 1: Configure Mirrored Networking ==="

# Check if .wslconfig exists in Windows
if [ -f "$WINDOWS_USERPROFILE/.wslconfig" ]; then
	echo "Found Windows .wslconfig, backing up..."
	cp "$WINDOWS_USERPROFILE/.wslconfig" "$WINDOWS_USERPROFILE/.wslconfig.bak"
fi

# Create .wslconfig with mirrored networking
echo "Creating .wslconfig with mirrored networking..."
cat > "$WSL_CONFIG" << 'EOF'
[wsl2]
networkingMode=mirrored
vmIdleTimeout=-1
EOF

echo "NOTE: You need to run 'wsl --shutdown' and restart WSL for changes to take effect."

echo ""
echo "=== Step 2: Hyper-V Firewall Ports ==="

# Script to run on Windows (as admin) to open firewall ports
FIREWALL_SCRIPT="$HOME/open_wsl_ports.ps1"

cat > "$FIREWALL_SCRIPT" << 'EOF'
# WSL2 Firewall Ports - Run as Administrator
# This script opens ports in Hyper-V firewall for WSL2

$vmCreatorId = '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}'

# Common development ports
$ports = @(22, 80, 443, 3000, 5173, 8000, 8080, 8443, 9090, 30000-50000)

# Create firewall rule
$ruleName = "WSL2-Dev-Ports-TCP"
if (!(Get-NetFirewallHyperVRule -Name $ruleName -ErrorAction SilentlyContinue)) {
    New-NetFirewallHyperVRule -Name $ruleName `
        -DisplayName "WSL2 Development Ports" `
        -Direction Inbound `
        -VMCreatorId $vmCreatorId `
        -Protocol TCP `
        -LocalPorts ($ports -join ',')
    Write-Host "Firewall rule created: $ruleName"
} else {
    Write-Host "Firewall rule already exists: $ruleName"
}

# UDP for Caddy HTTP/3
$udpRuleName = "WSL2-HTTP3-UDP"
if (!(Get-NetFirewallHyperVRule -Name $udpRuleName -ErrorAction SilentlyContinue)) {
    New-NetFirewallHyperVRule -Name $udpRuleName `
        -DisplayName "WSL2 HTTP/3 UDP" `
        -Direction Inbound `
        -VMCreatorId $vmCreatorId `
        -Protocol UDP `
        -LocalPorts 443
    Write-Host "Firewall rule created: $udpRuleName"
} else {
    Write-Host "Firewall rule already exists: $udpRuleName"
}

Write-Host ""
Write-Host "Done! Ports opened: $($ports -join ', ')"
Write-Host "Run 'wsl --shutdown' and restart WSL2"
EOF

echo "Created: $FIREWALL_SCRIPT"
echo "Run this in PowerShell as Administrator:"
echo "  Set-ExecutionPolicy Bypass -File $FIREWALL_SCRIPT"

echo ""
echo "=========================================="
echo "Setup complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Run the PowerShell script above as Administrator"
echo "2. Run: wsl --shutdown"
echo "3. Restart WSL2"
