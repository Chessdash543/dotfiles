#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

# .config/ -> ~/.config/
if [ -d "$DOTFILES/.config" ]; then
  for item in "$DOTFILES"/.config/*; do
    name=$(basename "$item")
    target="$HOME/.config/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    cp -r "$item" "$target"
    echo "copy ~/.config/$name OK"
  done
fi

# home/ -> $HOME/
if [ -d "$DOTFILES/home" ]; then
  for item in "$DOTFILES"/home/*; do
    name=$(basename "$item")
    target="$HOME/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    cp -r "$item" "$target"
    echo "copy ~/$name OK"
  done
fi
