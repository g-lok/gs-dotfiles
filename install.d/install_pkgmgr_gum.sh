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

## Setup gum environment variables
export FOREGROUND="#34f1ff"
export BACKGROUND="#211ba2"
export BORDER_FOREGROUND="#cb2ce0"
export GUM_INPUT_PROMPT_FOREGROUND="$FOREGROUND"
export GUM_CHOOSE_ITEM_FOREGROUND="$FOREGROUND"
