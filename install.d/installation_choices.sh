#!/usr/bin/env bash

## Get installation choices
OPTIONAL_APPS=("Developer_Tools" "Creative_Tools")
export APP_CATEGORIES=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --header "Select optional application categories to install.")

## I shouldn't have to do this,
## but gum choose up there isn't creating an array,
## but a newline delimited string.

case $APP_CATEGORIES in
*[![:space:]]*)
  readarray -t HOMEBREW_APP_CHOICES <<<"$APP_CATEGORIES"
  export HOMEBREW_APP_CHOICES
  ;;
*)
  declare -a APP_CATEGORIES
  export APP_CATEGORIES
  ;;
esac
