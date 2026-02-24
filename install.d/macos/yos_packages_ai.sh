#!/usr/bin/env bash

## Install Selected AI Tools

if [[ ${#GSDOT_AI_SELECT[@]} -gt 0 ]]; then
  for option in "${GSDOT_AI_SELECT[@]}"; do
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
      brew install --cask codex
      brew install openai-whisper
      brew install --cask chatgpt-atlas
      ;;
    OpenCode)
      mise use -g github:anomalyco/opencode
      ;;
    Windsurf)
      brew install --cask windsurf
      ;;
    esac
  done
fi
