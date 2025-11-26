#!/usr/bin/env bash

## Print Ascii logo with color.
ascii_art='
  _______/\        ________          __    _____.__.__
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/
'
## Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

## Gruvbox colors
gruv_hex=(
  "#f73028" # red     - errors, removals
  "#fb6a16" # orange  - search match, bright UI
  "#f7b125" # yellow  - warnings
  "#aab01e" # green   - additions, success
  "#7db669" # aqua    - type hints, diffs
  "#719586" # teal    - status bars, cursor
  "#c77089" # purple  - function names, git renamed
)
hex2rgb() {
  local hex=$(echo "${1^^}" | sed 's/#//g')
  local r=$(printf '%d' 0x${hex:0:2})
  local g=$(printf '%d' 0x${hex:2:2})
  local b=$(printf '%d' 0x${hex:4:2})
  printf '\e[38;2;%d;%d;%dm%s\e[m\n' "$r" "$g" "$b" "$2"
}

for i in "${!lines[@]}"; do
  color_index=$((i % ${#gruv_hex[@]}))
  hex2rgb "${gruv_hex[color_index]}" "${lines[i]}"
done
