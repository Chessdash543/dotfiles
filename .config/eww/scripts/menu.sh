#!/bin/bash

names=(
  "Firefox ESR"
  "Sublime Text"
  "Alacritty"
  "Btop++"
  "VLC"
  "GitHub Desktop"
  "Krita"
  "LibreOffice"
  "qBittorrent"
)

execs=(
  "firefox-esr"
  "subl"
  "alacritty"
  "btop"
  "vlc"
  "github-desktop"
  "krita"
  "libreoffice"
  "qbittorrent"
)

icons=(
  "/usr/share/icons/hicolor/128x128/apps/firefox.png"
  "/usr/share/icons/hicolor/128x128/apps/sublime-text.png"
  "/usr/share/icons/breeze/apps/48/utilities-terminal.svg"
  "/usr/share/icons/hicolor/scalable/apps/btop.svg"
  "/usr/share/icons/hicolor/256x256/apps/vlc.png"
  "/usr/share/icons/hicolor/256x256/apps/github-desktop.png"
  "/usr/share/icons/hicolor/256x256/apps/krita.png"
  "/usr/share/icons/hicolor/128x128/apps/libreoffice-writer.png"
  "/usr/share/icons/hicolor/128x128/apps/qbittorrent.png"
)

terminal=(
  false
  false
  false
  true
  false
  false
  false
  false
  false
)

json="["

for i in "${!names[@]}"; do
  [[ $i -ne 0 ]] && json+=","
  json+="{\"name\":\"${names[$i]}\",\"exec\":\"${execs[$i]}\",\"icon\":\"${icons[$i]}\",\"terminal\":\"${terminal[$i]}\"}"
done

json+="]"
echo "$json"
