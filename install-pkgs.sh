#!/bin/bash
set -e

echo "[1/4] Updating System"
sudo pacman -Syu --noconfirm

echo "[2/4] Installing pkgs from pacman"

sudo pacman -S --needed --noconfirm - < packages.txt

echo "[3/4] Installing pkgs from AUR (yay)"

if ! command -v yay &>/dev/null; then
  echo "yay not found, installing..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

yay -S --needed --noconfirm - < aur-pkglist.txt

echo "[4/4] Concluído"
