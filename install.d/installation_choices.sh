#!/usr/bin/env bash

## Get installation choices
OPTIONAL_APPS=("Developer_Tools" "Creative_Tools")
APP_CATEGORIES_SELECT=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --header "Select optional application categories to install.")
export GSDOT_APP_CATEGRIES=()
while IFS= read -r line; do
  GSDOT_APP_CATEGORIES+=("$line")
done <<<"$APP_CATEGORIES_SELECT"

for app_cat in "${GSDOT_APP_CATEGORIES[@]}"; do
  case $app_cat in
  Developer_Tools)
    source "$GSDOT_SCRIPTS/select_dev_languages.sh"
    source "$GSDOT_SCRIPTS/select_devops.sh"
    source "$GSDOT_SCRIPTS/select_ai.sh"
    ;;
  Creative_Tools)
    source "$GSDOT_SCRIPTS/select_creative.sh"
    ;;
  esac
done
