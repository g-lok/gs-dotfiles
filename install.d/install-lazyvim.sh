#!/usr/bin/env bash
### Install lazyvim

## Backup current neovim configs
# required
if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim{,.bak}
fi

# optional but recommended
if [ -d ~/.local/share/nvim ]; then
  mv ~/.local/share/nvim{,.bak}
fi

if [ -d ~/local/state/nvim ]; then
  mv ~/.local/state/nvim{,.bak}
fi

if [ -d ~/.cache/nvim ]; then
  mv ~/.cache/nvim{,.bak}
fi

## Install and remove .git folder
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
