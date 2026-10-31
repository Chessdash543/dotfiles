#!/bin/bash
set -e

#!/usr/bin/env bash

printf "This dotfiles will overwrite your dotfiles.\nDo you want to continue? (y/n): "
read -r answer

case "$answer" in
    [Yy])
        echo "Continuing..."
        ;;
    [Nn])
        echo "Aborted."
        exit 1
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac

./install-pkgs.sh
./install-services.sh
./install-dotfiles.sh

echo "Setup completed"
