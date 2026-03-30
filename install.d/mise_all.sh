#!/usr/bin/env zsh
## Select and install mise programming languages
mise use --global erlang@latest
mise use --global elixir@latest
mise x elixir -- mix local.hex --force
mise plugin install flutter https://github.com/nyuyuyu/asdf-flutter.git
mise use --global flutter@latest
mise use --global go@latest
mise use --global java@latest
mise plugin install kotlin https://github.com/mise-plugins/mise-kotlin.git
mise use --global kotlin@latest
mise use --global node@lts
# mise use --global "php@$latest_php"
mise use --global python@latest
mise plugins install poetry https://github.com/mise-plugins/mise-poetry.git
mise use --global poetry@latest
mise use --global uv@latest
mise use --global ruby@latest
mise settings add idiomatic_version_file_enable_tools ruby
mise x ruby -- gem install rails --no-document
mise use --global rust
mise use --global zig@latest
