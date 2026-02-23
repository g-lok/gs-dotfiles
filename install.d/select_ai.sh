#!/usr/bin/env bash

## Select AI tools
AI_OPTS=(
  "Cursor"
  "Claude Code"
  "Ollama"
  "OpenAI"
  "Windsurf"
)
export CHOSEN_AI_TOOLS=$(gum choose "${AI_OPTS[@]}" --no-limit --header "Select optional AI tools to install.")
