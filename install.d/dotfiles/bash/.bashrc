if [ -t 1 ]; then
  if [ -d "$HOME"/.shellrc/ ]; then
    for file in "$HOME"/.shellrc/*.sh; do
      [ -e "$file" ] || break
      source "$file"
    done
  fi
fi
