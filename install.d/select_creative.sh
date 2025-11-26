#!/usr/bin/env bash

## Select creativity apps
CREATIVE_OPTIONS=(
  "Audacity"
  "Gimp"
  "Krita"
  "Blender"
  "Furnace Tracker"
)
export CREATIVE_SELECTIONS=$(gum choose "${CREATIVE_OPTIONS[@]}" --no-limit --header "Select optional creativity apps to install.")
