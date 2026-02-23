#!/usr/bin/env bash

## Select and install mise programming languages

if [[ -n "$GSDOT_SELECTED_LANGUAGES" ]]; then
  for language in $GSDOT_SELECTED_LANGUAGES; do
    case $language in
    Elixir)
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    Flutter)
      mise plugin install flutter https://github.com/nyuyuyu/asdf-flutter.git
      mise use --global flutter@latest
      ;;
    Go)
      mise use --global go@latest
      ;;
    Java)
      mise use --global java@latest
      ;;
    Kotlin)
      mise plugin install kotlin https://github.com/mise-plugins/mise-kotlin.git
      mise use --global kotlin@latest
      ;;
    Node.js)
      mise use --global node@lts
      ;;
    PHP)
      latest_php=$("curl -s https://api.github.com/repos/rozsazoltan/php/releases | jq '.[].tag_name | ltrimstr("v")' | sort -V | tail -n 1")
      mise use --global "php@$latest_php"
      ;;
    Python)
      mise use --global python@latest
      ;;
    Ruby)
      mise use --global ruby@latest
      mise settings add idiomatic_version_file_enable_tools ruby
      mise x ruby -- gem install rails --no-document
      ;;
    Rust)
      # bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      mise use --global rust
      ;;
    Zig)
      mise use --global zig@latest
      ;;
    esac
  done
fi
