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

if command -v carapace &>/dev/null; then
  export UserConfigDir="$HOME/.config"
  case $myshell in
  bash)
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
    source <(carapace _carapace)
    ;;
  zsh)
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace)
    ;;
  esac
fi

if command -v mise &>/dev/null; then
  eval "$(mise activate "$myshell")"
fi

if command -v fzf &>/dev/null; then
  eval "$(fzf --"$myshell")"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init "$myshell")"
fi
