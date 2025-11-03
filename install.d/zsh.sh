#!/usr/bin/env zsh

## Install oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh-My-Zsh already installed."
else
  ZSH= sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

## Set custom folder
export ZSH_CUSTOM="$HOME"/.oh-my-zsh/custom

### Install zsh plugins
git -C "$ZSH_CUSTOM/plugins/zsh-autosuggestions" pull  || git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git -C "$ZSH_CUSTOM/plugins/fzf-tab" pull || git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
git -C "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" pull || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git -C "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" pull || git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git -C "$ZSH_CUSTOM/plugins/zsh-autocomplete" pull || git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"
git -C "$ZSH_CUSTOM/plugins/fzf-tab" pull || git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
