#!/bin/bash
set -e

echo -e "This dotfiles will overwrite your dotfiles.\nDo you want to continue? (y/n)"
read answer

if [[ "$answer" == "y" ]]; then
    echo "Continuing..."
else
    echo "Aborted."
fi
./install-pkgs.sh
./install-services.sh
./install-dotfiles.sh

echo "Setup completed"
