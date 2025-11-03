#!/usr/bin/env bash

## GNU Stow to create config file symlinks
export SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
stow --target="$HOME" $ --restow SCRIPT_PATH/dotfiles/*
