#!/bin/bash

names=(
  "Firefox ESR"
  "Sublime Text"
  "Btop++"
  "VLC"
  "GitHub Desktop"
  "LibreOffice"
  "qBittorrent"
)

execs=(
  "firefox-esr"
  "subl"
  "foot btop"
  "vlc"
  "github-desktop"
  "libreoffice"
  "qbittorrent"
)

icons=(
  "/usr/share/icons/WhiteSur-dark/apps/scalable/firefox-esr.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/sublime-text.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/btop.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/vlc.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/github-desktop.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/libreoffice-writer.svg"
  "/usr/share/icons/WhiteSur-dark/apps/scalable/qbittorrent.svg"
)

terminal=(
  false
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
