#!/usr/bin/env bash

## Select Devops tooling options
DEVOPS_OPTIONS=(
  "Kubernetes"
  "Google Cloud"
  "AWS"
  "Azure"
  "Geekbench"
  "Tailscale"
)
export CHOSEN_DEVOPS_OPTIONS=$(gum choose "${DEVOPS_OPTIONS[@]}" --no-limit --header "Select optional DevOps tools to install.")
