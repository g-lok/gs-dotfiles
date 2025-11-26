#!/usr/bin/env bash

## Get user input
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Gs-Dotfiles" "Let's get started!"

export NAME=$(gum input --prompt "Please enter full name: ")

## Make sure valid email.
while :
do
  EMAIL=$(gum input --prompt "Please enter email: ")
  if [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
    export EMAIL 
    break
  else
    echo "Email address $EMAIL is invalid."
  fi
done

## Make sure you dummies type the correct password.
while :
do
  HOMEBREW_PASSWORD=$(gum input --password --prompt "Please enter your user password: ")
  pwd2=$(gum input --password --prompt "Please re-enter your user password: ")
  if [[ "$HOMEBREW_PASSWORD" == "$pwd2" ]]; then
    if echo "$HOMEBREW_PASSWORD" | sudo -lS &> /dev/null; then
      echo "Correct password."
      export HOMEBREW_PASSWORD
      break
    else
      echo "Wrong password."
    fi
  else; then
    echo "Passwords don't match."
  fi
done

## Get installation choices
source "$SCRIPTS_DIR/installation_choices.sh"
source "$SCRIPTS_DIR/select_desktop_optionals.sh"

## Install optional packages
if [[ ${#HOMEBREW_APP_CHOICES[@]} -gt 0 ]]; then
  for option in "${HOMEBREW_APP_CHOICES[@]}"; do
    case ${option} in
    "Developer_Tools")
      source "$SCRIPTS_DIR/select-dev-languages.sh"
      source "$SCRIPTS_DIR/select_devops.sh"
      source "$SCRIPTS_DIR/select_dbs.sh"
      source "$SCRIPTS_DIR/select_ai.sh"
      ;;
    "Creative_Tools")
      source "$SCRIPTS_DIR/select_creative.sh"
      ;;
    esac
  done
fi

