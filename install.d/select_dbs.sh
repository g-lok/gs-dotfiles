#!/usr/bin/env bash

## Select DBs
AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
export GSDOT_SELECT_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
