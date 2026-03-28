#!/usr/bin/env bash
## Use GNU Stow to set dotfile configs for GPi5
## Headless Raspberry Pi server - no GUI

cd "$(dirname "$0")" || exit 0
pwd

stow_and_copy() {
	config=$1
	echo "Stowing: $config"
	stow --target="$HOME" --adopt "${config}" --override='.*' 2>/dev/null || true
	stow --target="$HOME" --restow "${config}" 2>/dev/null || true
}

GPI5_CONFIGS=(
	"zellij-linux"
	"neovim"
	"mise"
	"shellrc"
	"starship"
	"yazi"
	"zsh"
)

for config in "${GPI5_CONFIGS[@]}"; do
	if [ -d "$config" ]; then
		stow_and_copy "$config"
	fi
done

echo "Done!"
