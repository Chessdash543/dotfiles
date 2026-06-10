#!/bin/bash
set -e

SERVICES=(
  NetworkManager
  bluetooth
  pipewire
  wireplumber
)

for s in "${SERVICES[@]}"; do
  sudo systemctl enable --now "$s"
done
