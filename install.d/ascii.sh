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

## Define the color gradient (shades of cyan and blue)
colors=(
  # '\033[38;5;81m' # Cyan
  # '\033[38;5;75m' # Light Blue
  # '\033[38;5;69m' # Sky Blue
  # '\033[38;5;63m' # Dodger Blue
  # '\033[38;5;57m' # Deep Sky Blue
  # '\033[38;5;51m' # Cornflower Blue
  # '\033[38;5;45m' # Royal Blue
  # Gruvbox
  "167=f7/30/28" # red     - errors, removals
  "208=fb/6a/16" # orange  - search match, bright UI
  "214=f7/b1/25" # yellow  - warnings
  "142=aa/b0/1e" # green   - additions, success
  "108=7d/b6/69" # aqua    - type hints, diffs
  "109=71/95/86" # teal    - status bars, cursor
  "175=c7/70/89" # purple  - function names, git renamed
)
#
# ## Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"
#
# ## Print each line with the corresponding color
for i in "${!lines[@]}"; do
  color_index=$((i % ${#colors[@]}))
  echo -e "${colors[color_index]}${lines[i]}"
done
