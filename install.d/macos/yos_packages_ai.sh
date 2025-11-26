#!/usr/bin/env bash

## Install Selected AI Tools

if [[ ${#CHOSEN_AI_TOOLS[@]} -gt 0 ]]; then
  for option in "${CHOSEN_AI_TOOLS[@]}"; do
    case ${option} in
    Ollama)
      brew install ollama
      ;;
    Cursor)
      brew install --cask cursor
      ;;
    Claude)
      brew install --cask claude-code
      ;;
    Windsurf)
      brew install --cask windsurf
      ;;
    esac
  done
fi
