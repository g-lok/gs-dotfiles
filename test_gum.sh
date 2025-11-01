#!/usr/bin/env bash

## Test script for gum shit

OPTIONS=("one and" "two and" "three and" "four and" "five and" "six and")
export CHOICES=$(gum choose "${OPTIONS[@]}" --no-limit --header "Select some options")

echo $CHOICES
for choice in "${CHOICES[@]}"; do
  echo "$choice"
done
