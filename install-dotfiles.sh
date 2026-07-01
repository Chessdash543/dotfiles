#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
CONFIG="$DOTFILES/dotfiles.conf"

[ -f "$CONFIG" ] && source "$CONFIG"

cd "$DOTFILES"

for app in "${CONFIG_APPS[@]}"; do
  if [ -d "$app" ]; then
    stow "$app"
    echo "stow $app OK"
  fi
done

if [ -d home ]; then
  stow home
  echo "stow home OK"
fi
