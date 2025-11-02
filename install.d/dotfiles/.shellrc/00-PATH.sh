#!/usr/bin/env bash

export PATH=$PATH:$HOME/bin
# export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# export PATH="$HOME/Library/Python/3.9/bin:$PATH"

### Homebrew
## Figure out where brew is installed.
BREW_BIN="/usr/local/bin/brew"
if [ -f "/opt/homebrew/bin/brew" ]; then
  BREW_BIN="/opt/homebrew/bin/brew"
fi

## Main homebrew config
eval "$($BREW_BIN shellenv)"

## Homebrew gnu apps by default
if type "${BREW_BIN}" &>/dev/null; then
  export BREW_PREFIX="$("${BREW_BIN}" --prefix)"
  for bindir in "${BREW_PREFIX}/opt/"*"/libexec/gnubin"; do export PATH=$bindir:$PATH; done
  for bindir in "${BREW_PREFIX}/opt/"*"/bin"; do export PATH=$bindir:$PATH; done
  for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
  for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done
fi

export GOPATH="$HOME/Go"
export PATH="$HOME/Go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
