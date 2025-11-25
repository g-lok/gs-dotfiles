#!/usr/bin/env bash
### Install lazyvim

## Bail if lazyvim is already installed
if [ -f ~/.config/nvim/lua/config/lazy.lua ]; then
  return
  exit 0
fi

## Backup current neovim configs
# required
if [ -d ~/.config/nvim ]; then
  cp -r ~/.config/nvim{,.bak}
  rm -rf ~/.config/nvim/
fi

# optional but recommended
if [ -d ~/.local/share/nvim ]; then
  cp -r ~/.local/share/nvim{,.bak}
  rm -rf ~/.local/share/nvim
fi

if [ -d ~/local/state/nvim ]; then
  cp -r ~/.local/state/nvim{,.bak}
  rm -rf ~/.local/state/nvim
fi

if [ -d ~/.cache/nvim ]; then
  cp -r ~/.cache/nvim{,.bak}
  rm -rf ~/cache/nvim
fi

## Install and remove .git folder
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
