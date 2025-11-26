#!/usr/bin/env bash

## Install Selected DevOps Tools.
mise use -global terraform

## TODO: Figure out the mise for all of these.
if [[ ${#CHOSEN_DEVOPS_TOOLS[@]} -gt 0 ]]; then
  for option in "${CHOSEN_DEVOPS_TOOLS[@]}"; do
    case ${option} in
    Kubernetes)
      brew install kubectl
      brew install k9s
      brew install minikube
      ;;
    Google)
      brew install --cask google-cloud-sdk
      ;;
    AWS)
      brew install awscli
      ;;
    Azure)
      brew install azure-cli
      ;;
    Geekbench)
      brew install --cask geekbench
      ;;
    Tailscale)
      brew install tailscale
      ;;
    esac
  done
fi
