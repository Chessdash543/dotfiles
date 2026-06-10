#!/bin/bash
set -e

./install-pkgs.sh
./install-services.sh
./install-dotfiles.sh

echo "Setup completo"
