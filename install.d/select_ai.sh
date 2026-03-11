#!/usr/bin/env bash

## Select AI tools
AI_OPTS=(
  "Cursor"
  "Claude Code"
  "Ollama"
  "OpenAI"
  "OpenClawd"
  "OpenCode"
  "Windsurf"
)
export GSDOT_AI_SELECT=$(gum choose "${AI_OPTS[@]}" --no-limit --header "Select optional AI tools to install.")
