#!/usr/bin/env bash

## Install Selected DevOps Tools.
if [[ ${#CHOSEN_DEVOPS_TOOLS[@]} -gt 0 ]]; then
  for option in "${CHOSEN_DEVOPS_TOOLS[@]}"; do
    case ${option} in
    Kubernetes) ;;
    Google) ;;
    AWS) ;;
    Azure) ;;
    Geekbench) ;;
    Tailscale) ;;
    esac
  done
fi
