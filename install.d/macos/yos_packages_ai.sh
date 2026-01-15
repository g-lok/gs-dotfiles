#!/usr/bin/env bash

## Install Selected AI Tools

if [[ ${#CHOSEN_AI_TOOLS[@]} -gt 0 ]]; then
  for option in "${CHOSEN_AI_TOOLS[@]}"; do
    case ${option} in
    Claude)
      brew install --cask claude-code
      ;;
    Cursor)
      brew install --cask cursor
      ;;
    Ollama)
      brew install ollama
      ;;
    OpenAI)
      brew install anomalyco/tap/opencode
      ;;
    Windsurf)
      brew install --cask windsurf
      ;;
    esac
  done
fi
