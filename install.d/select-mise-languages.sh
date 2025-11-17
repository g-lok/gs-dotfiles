#!/usr/bin/env bash

## Select and install mise programming languages

MISE_OPTIONS=("Ruby on Rails" "Node.js" "Go" "Python" "Elixir" "Rust" "Java" "Flutter")
languages=$(gum choose "${MISE_OPTIONS[@]}" --no-limit --height 10 --header "Select programming languages")

if [[ -n "$languages" ]]; then
  for language in $languages; do
    case $language in
    Ruby)
      mise use --global ruby@latest
      mise settings add idiomatic_version_file_enable_tools ruby
      mise x ruby -- gem install rails --no-document
      ;;
    Node.js)
      mise use --global node@lts
      ;;
    Go)
      mise use --global go@latest
      ;;
    Python)
      mise use --global python@latest
      ;;
    Elixir)
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    Rust)
      bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      ;;
    Java)
      mise use --global java@latest
      ;;
    Flutter)
      mise plugin install flutter https://github.com/nyuyuyu/asdf-flutter.git
      mise install flutter@latest
      ;;
    esac
  done
fi
