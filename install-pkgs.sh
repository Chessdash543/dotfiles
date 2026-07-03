#!/bin/bash
set -e

echo "[1] Atualizando sistema"
sudo pacman -Syu --noconfirm

echo "[2] Instalando pacotes do pacman"

sudo pacman -S --needed --noconfirm - < packages.txt

echo "[3] Instalando AUR (yay)"

if ! command -v yay &>/dev/null; then
  echo "yay não encontrado. Instalando..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

yay -S --needed --noconfirm - < aur-pkglist.txt

echo "[4] Ativando serviços essenciais"


echo "[5] Concluído"
