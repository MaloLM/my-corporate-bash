#!/bin/bash

echo "This will remove all files related to my-corporate-bash."
read -r -p "Are you sure? (y/n): " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]') # to lowercase

USER_PROFILE=$("$HOME/.my-corporate-bash/get_profile.sh")

if [[ $confirm == "y" || $confirm == "yes" ]]; then
    sudo rm /usr/local/bin/my-corporate-bash
    "$HOME"/.my-corporate-bash/clear_bash.sh "$USER_PROFILE"
    rm -rf ~/.my-corporate-bash/

    echo "my-corporate-bash has been uninstalled."
else
    echo "Uninstallation aborted."
fi
