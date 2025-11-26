#!/usr/bin/env bash

## Install Homebrew
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
else
  echo "Homebrew is already installed. Updating..."
  brew update >/dev/null
  brew upgrade >/dev/null
fi

## Temporarily load Homebrew's config and PATH and whatnot
command -v brew >/dev/null || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH" >/dev/null
command -v brew >/dev/null && eval "$(brew shellenv)" >/dev/null

## Install gum
if [[ $(command -v gum) == "" ]]; then
  brew install gum >/dev/null
else
  echo "Gum already installed"
fi

## Gruvbox colors
GRUV_YELLOW="#dfc71d"
GRUV_ORANGE="#d65d0e"
GRUV_GREEN="#40a02b"
GRUV_MUAVE="#b16286"
GRUV_SKY="#04a5e5"
## Setup gum environment variables
export FOREGROUND="$GRUV_YELLOW"
export BACKGROUND="$GRUV_ORANGE"
export BORDER_FOREGROUND="$GRUV_GREEN"
export GUM_INPUT_PROMPT_FOREGROUND="$GRUV_SKY"
export GUM_INPUT_CURSOR_FOREGROUND="$GRUV_MUAVE"
export GUM_CHOOSE_ITEM_FOREGROUND="$FOREGROUND"
# export GUM_CHOOSE_SELECTED_FOREGROUND=""
