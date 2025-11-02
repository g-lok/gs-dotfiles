#!/usr/bin/env bash

if [ -n "$BASH_VERSION" ]; then
  echo "Running under Bash"
  myshell="bash"
elif [ -n "$ZSH_VERSION" ]; then
  echo "Running under Zsh"
  myshell="zsh"
fi

# Activate terminal stuff
if command -v mise &>/dev/null; then
  eval "$(mise activate "$myshell")"
fi

if command -v fzf &>/dev/null; then
  eval "$(fzf --"$myshell")"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init "$myshell")"
fi
