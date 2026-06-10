201~200~#!/bin/bash

set -e

echo "[1/7] Instalando pacotes..."
if [ -f packages.txt ]; then
sudo pacman -S --needed $(grep -v '^#' packages.txt)
fi

echo "[2/7] Criando diretórios..."
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/fonts

echo "[3/7] Sincronizando configs..."
for dir in config/*; do
    name=$(basename "$dir")
    mkdir -p "$HOME/.config/$name"
    rsync -a --delete "$dir/" "$HOME/.config/$name/"
done

echo "[4/7] Copiando arquivos da HOME..."
cp -rf home/.[!.]* ~/ 2>/dev/null || true

echo "[5/7] Copiando scripts..."
cp -rf local/bin/* ~/.local/bin/ 2>/dev/null || true
chmod +x ~/.local/bin/* 2>/dev/null || true

echo "[6/7] Instalando fontes..."
cp -rf local/fonts/* ~/.local/share/fonts/
fc-cache -fv

echo "[7/7] Ajustando caminhos..."
sed -i "s|/home/ryanv|$HOME|g" ~/.config/gtk-4.0/gtk.css 2>/dev/null || true
sed -i "s|/home/ryanv|$HOME|g" ~/.config/qt6ct/qt6ct.conf 2>/dev/null || true

echo "Concluído."
