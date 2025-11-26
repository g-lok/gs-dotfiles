#!/usr/bin/env bash

## Select Dev Languages to Install
LANGUAGE_OPTIONS=(
  "Elixir"
  "Flutter"
  "Go"
  "Java"
  "Kotlin"
  "Node.js"
  "PHP"
  "Python"
  "Ruby on Rails"
  "Rust"
)
export SELECTED_LANGUAGES=$(gum choose "${LANGUAGE_OPTIONS[@]}" --no-limit --height 10 --header "Select programming SELECTED_LANGUAGES")
