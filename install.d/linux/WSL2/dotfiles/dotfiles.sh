#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs for WSL2
## Headless environment - no GUI apps

cd "$(dirname "$0")" || exit 0
pwd

OS=$(uname -s)
if [[ "$(uname -m)" == "arm64" ]]; then
	arch="arm64"
else
	arch="intel"
fi

stow_and_copy() {
	config=$1
	echo "Stowing: $config"
	stow --target="$HOME" --adopt "${config}" --override='.*' 2>/dev/null || true
	stow --target="$HOME" --restow "${config}" 2>/dev/null || true
}

WSL2_CONFIGS=(
	"zellij-linux"
	"neovim"
	"mise"
	"shellrc"
	"starship"
	"yazi"
	"zsh"
)

for config in "${WSL2_CONFIGS[@]}"; do
	if [ -d "$config" ]; then
		stow_and_copy "$config"
	fi
done

echo "Done!"
