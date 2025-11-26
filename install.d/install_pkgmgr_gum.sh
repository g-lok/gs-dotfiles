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
GRUV_RED="#d20f39"
GRUV_GREEN="#40a02b"
GRUV_MUAVE="#8839ef"
GRUV_SKY="#04a5e5"
GRUV_BLUE="#1e66f5"
GRUV_DARKGREY="#4c4f69"

### Setup gum environment variables
## gum style
export FOREGROUND="$GRUV_YELLOW"
export BACKGROUND="$GRUV_DARKGREY"
export BORDER_FOREGROUND="$GRUV_GREEN"

## gum input
export GUM_INPUT_PROMPT_FOREGROUND="$GRUV_SKY"
export GUM_INPUT_PROMPT_BACKGROUND="$GRUV_DARKGREY"
export GUM_INPUT_CURSOR_FOREGROUND="$GRUV_ORANGE"
export GUM_INPUT_CURSOR_BACKGROUND="$GRUV_YELLOW"

## gum choose
export GUM_CHOOSE_HEADER_FOREGROUND="$GRUV_YELLOW"
export GUM_CHOOSE_CURSOR_FOREGROUND="$GRUV_RED"
export GUM_CHOOSE_ITEM_FOREGROUND="$GRUV_GREEN"
export GUM_CHOOSE_SELECTED_FOREGROUND="$GRUV_YELLOW"
export GUM_CHOOSE_SELECTED_BACKGROUND="$GRUV_ORANGE"

## gum confirm
export GUM_CONFIRM_PROMPT_FOREGROUND="$GRUV_YELLOW"
export GUM_CONFIRM_PROMPT_BACKGROUND="$GRUV_BLUE"
export GUM_CONFIRM_SELECTED_FOREGROUND="$GRUV_YELLOW"
export GUM_CONFIRM_SELECTED_BACKGROUND="$GRUV_GREEN"
export GUM_CONFIRM_UNSELECTED_FOREGROUND="$GRUV_YELLOW"
export GUM_CONFIRM_UNSELECTED_BACKGROUND="$GRUV_DARKGREY"
