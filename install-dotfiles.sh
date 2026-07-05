#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

cd "$DOTFILES"

# .config (--no-folding cria symlinks individuais, não uma pasta inteira)
if [ -d .config ]; then
  stow --no-folding .config
  echo "stow .config OK"
fi

# $HOME files
if [ -d home ]; then
  stow home
  echo "stow home OK"
fi
