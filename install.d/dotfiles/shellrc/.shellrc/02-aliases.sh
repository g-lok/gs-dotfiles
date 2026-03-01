#!/usr/bin/env bash
# G's BASH aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pcregrep='pcregrep --color=auto'

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
unalias gcp
alias gitcp='git cherry-pick'
unalias gpr
alias gitpr='git pull --rebase'
unalias grm
alias gitrm='git rm'

# Jujutsu aliases
alias jjc="jj commit"
alias jjn="jj new"
alias jje="jj edit"
alias jjd="jj describe -m"
alias jjdi="jj diff"
alias jjid="jj interdiff"
alias jjgi="jj git init"
alias jjgf="jj git fetch"
alias jjbc="jj bookmark create"
alias jjgpb="jj git push --bookmark"
alias jjgpt="jj git push --tracked"
alias jjgp="jj git push --change @"
alias jjbt="jj bookmark track"
alias jja="jj abandon"
alias jjopl="jj operations log"
alias jjevl="jj evolog"
alias jjs="jj squash"
alias jjr="jj rebase"
alias jjp="jj parallelize"
alias jjsp="jj split"
alias jjres="jj resolve"
