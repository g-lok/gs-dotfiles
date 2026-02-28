#!/usr/bin/env bash

if [ -n "$BASH_VERSION" ]; then
  myshell="bash"
elif [ -n "$ZSH_VERSION" ]; then
  myshell="zsh"
fi

## Activate terminal stuff
if command -v starship &>/dev/null; then
  eval "$(starship init "$myshell")"
fi

if command -v mise &>/dev/null; then
  eval "$(mise activate "$myshell")"
  export MISE_POETRY_AUTO_INSTALL=1
  export MISE_POETRY_VENV_AUTO=1
fi

if command -v fzf &>/dev/null; then
  eval "$(fzf --"$myshell")"
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

  # Setup fzf previews
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init "$myshell")"
fi
