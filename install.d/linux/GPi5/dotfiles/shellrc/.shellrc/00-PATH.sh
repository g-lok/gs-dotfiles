#!/usr/bin/env bash

export PATH=$PATH:$HOME/bin

### Homebrew
## Figure out where brew is installed.
BREW_BIN=""
for path in \
	"/home/linuxbrew/.linuxbrew/bin/brew" \
	"$HOME/.linuxbrew/bin/brew" \
	"/opt/homebrew/bin/brew" \
	"/usr/local/bin/brew"
do
	if [ -f "$path" ]; then
		BREW_BIN="$path"
		break
	fi
done

if [ -n "$BREW_BIN" ]; then
	## Main homebrew config
	eval "$($BREW_BIN shellenv)"
fi

export GOPATH="$HOME/Go"
export PATH="$HOME/Go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
