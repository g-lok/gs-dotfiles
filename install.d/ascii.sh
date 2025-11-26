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
  # "167=f7/30/28" # red     - errors, removals
  # "208=fb/6a/16" # orange  - search match, bright UI
  # "214=f7/b1/25" # yellow  - warnings
  # "142=aa/b0/1e" # green   - additions, success
  # "108=7d/b6/69" # aqua    - type hints, diffs
  # "109=71/95/86" # teal    - status bars, cursor
  # "175=c7/70/89" # purple  - function names, git renamed
)
# define -a gruv_converted
hex2rgb() {
  local hex=$(echo "${1^^}" | sed 's/#//g')
  local r=$(printf '%d' 0x${hex:0:2})
  local g=$(printf '%d' 0x${hex:2:2})
  local b=$(printf '%d' 0x${hex:4:2})
  printf '\e[38;2;%d;%d;%dm%s\e[m\n' "$r" "$g" "$b" "$2"
}
# Detect terminal escape sequence wrapping
# if [ "${TERM%%-*}" = "screen" ]; then
#   if [ -n "$TMUX" ]; then
#     prefix="\033Ptmux;\033"
#     suffix="\033\\"
#   else
#     prefix="\033P"
#     suffix="\033\\"
#   fi
# else
#   prefix=""
#   suffix="\033\\"
# fi
#
# set_color() {
#   index="${1%%=*}"
#   value="${1#*=}"
#   printf "${prefix}\033]4;%s;rgb:%s\007${suffix}" "$index" "$value"
# }
#
# # Loop over all defined colors
# for color in "${colors[@]}"; do
#   set_color "$color"
# done

## Define the color gradient (shades of cyan and blue)
colors=(
  # '\033[38;5;81m' # Cyan
  # '\033[38;5;75m' # Light Blue
  # '\033[38;5;69m' # Sky Blue
  # '\033[38;5;63m' # Dodger Blue
  # '\033[38;5;57m' # Deep Sky Blue
  # '\033[38;5;51m' # Cornflower Blue
  # '\033[38;5;45m' # Royal Blue
)
#
#
# ## Print each line with the corresponding color
for i in "${!lines[@]}"; do
  color_index=$((i % ${#gruv_hex[@]}))
  hex2rgb "${gruv_hex[color_index]}" "${lines[i]}"
done
