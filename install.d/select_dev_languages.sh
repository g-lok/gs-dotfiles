#!/usr/bin/env bash

## Select Dev Languages to Install
LANGUAGE_OPTIONS=(
  "Elixir"
  "Flutter"
  "Go"
  "Java"
  "Kotlin"
  "Node.js"
  # "PHP" #TODO: broken curl
  "Python"
  "Ruby on Rails"
  "Rust"
  "Zig"
)
export SELECTED_LANGUAGES=$(gum choose "${LANGUAGE_OPTIONS[@]}" --no-limit --height 10 --header "Select programming SELECTED_LANGUAGES")
