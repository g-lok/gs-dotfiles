#!/usr/bin/env bash
# G's aliases
alias bpp="bat -pp"
alias nv="nvim"
alias oc="opencode"
alias zdtab="zellij action new-tab --layout default"
# alias sudo="sudo -E "
# Knock-off Linux pbcopy and pbpaste
if [ "$(uname -s)" = "Linux" ]; then
  alias sudo='sudo '
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  export GIO_EXTRA_MODULES=""
fi

# Misc environment variables
export EDITOR=nvim

# Git aliases
alias gpum='git pull upstream master -v'
alias gfum='git fetch upstream master -v'
alias gpom='git pull origin master -v'
alias gfom='git fetch origin master -v'

### Omakub aliases
# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# alias fd='fdfind'
alias cd='z'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
alias g='git'
alias d='docker'
alias r='rails'
alias lzg='lazygit'
alias lzd='lazydocker'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

## Unalias oh-my-zsh git aliases that conflic with gnu cli tools
if [ -n "$ZSH_VERSION" ]; then
  unalias gcp
  alias gitcp='git cherry-pick'
  unalias gpr
  alias gitpr='git pull --rebase'
  unalias grm
  alias gitrm='git rm'
fi

# Jujutsu aliases
alias jja="jj abandon"
alias jjb="jj bookmark"
alias jjba="jj bookmark advance"
alias jjbc="jj bookmark create"
alias jjbd="jj bookmark delete"
alias jjbf="jj bookmark forget"
alias jjbl="jj bookmark list"
alias jjbm="jj bookmark move"
alias jjbrn="jj bookmark rename"
alias jjbs="jj bookmark set"
alias jjbt="jj bookmark track"
alias jjbut="jj bookmark untrack"
alias jjc="jj commit"
alias jjd="jj describe -m"
alias jjdi="jj diff"
alias jjdu="jj duplicate"
alias jje="jj edit"
alias jjevl="jj evolog"
alias jjf="jj file"
alias jjft="jj file track"
alias jjfu="jj file untrack"
alias jjg="jj git"
alias jjgcl="jj git clone"
alias jjgco="jj git colocation"
alias jjgex="jj git export"
alias jjgf="jj git fetch"
alias jjgi="jj git init"
alias jjgim="jj git import"
alias jjgp="jj git push --change @"
alias jjgpb="jj git push --bookmark"
alias jjgpt="jj git push --tracked"
alias jjgr="jj git remote"
alias jjgrt="jj git root"
alias jjid="jj interdiff"
alias jjl="jj log -r 'all()'"
alias jjn="jj new"
alias jjnm="jj new -m"
alias jjnx="jj next"
alias jjopl="jj operation log"
alias jjp="jj parallelize"
alias jjr="jj rebase"
alias jjrsl="jj resolve"
alias jjrst="jj restore"
alias jjrvt="jj revert"
alias jjs="jj squash"
alias jjsn="jj sign"
alias jjsmp="jj simplify-parents"
alias jjsp="jj split"
alias jjspr="jj sparse"
alias jjst="jj status"
alias jjt="jj tag"
alias jju="jj undo"
alias jjusn="jj unsign"
alias jjw="jj workspace"
