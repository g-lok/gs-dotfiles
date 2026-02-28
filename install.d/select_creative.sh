#!/usr/bin/env bash

## Select creativity apps
CREATIVE_OPTIONS=(
  "Audacity"
  "Gimp"
  "Krita"
  "Blender"
  "Furnace Tracker"
  "VCV Rack"
)
export GSDOT_CREATIVE_SELECT=$(gum choose "${CREATIVE_OPTIONS[@]}" --no-limit --header "Select optional creativity apps to install.")
