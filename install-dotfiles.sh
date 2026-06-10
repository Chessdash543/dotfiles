#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

cd "$DOTFILES"

stow nvim
stow hypr
stow kitty
stow waybar
stow btop
stow fastfetch
stow gtk-3.0
stow gtk-4.0
stow qt5ct
stow qt6ct
stow swaync
stow walker
stow wlogout
stow yazi
