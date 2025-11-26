#!/usr/bin/env bash

## Select AI tools
AI_OPTS=(
  "Ollama"
  "Cursor"
  "Claude Code"
  "Windsurf"
)
export CHOSEN_AI_TOOLS=$(gum choose "${AI_OPTS[@]}" --no-limit --header "Select optional AI tools to install.")
