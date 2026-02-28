#!/usr/bin/env bash

# Get the operating system name
OS=$(uname -s)
case "$OS" in
"Linux")
  # Add Linux-specific commands here
  if [ -n "$DISPLAY" ]; then
    echo "Running on Linux (GUI)"
    export SCRIPT_OS="linux_gui"
  else
    echo "Running on Linux Headless"
    export SCRIPT_OS="linux_headless"
  fi
  ;;
"Darwin")
  echo "This script is running on macOS."
  export SCRIPT_OS="MacOS"
  ## Add macOS-specific commands here
  ## Install XCode Tools (required for Homebrew)
  if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1; then
    echo "Command Line Tools are installed"
  else
    echo "Command Line Tools are not installed."
    echo "You will be prompted to install Xcode command line tools."
    echo "Please Install Xcode command line tools before resuming."
    xcode-select --install
  fi
  ;;
*)
  echo "This script is running on an unknown operating system: $OS"
  exit 1
  ;;
esac
