#!/bin/bash

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    printf "\n"
    echo "#############################################"
    echo "# Please run this command with sudo.        #"
    echo "# Example: sudo mycorporatebash uninstall   #"
    echo "#############################################"
    printf "\n"
    exit 1
fi

echo "This will remove all files related to mycorporatebash."
read -r -p "Are you sure? (y/n): " confirm

# Convert the response to lowercase to simplify checking
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ $confirm == "y" || $confirm == "yes" ]]; then
    # Remove the ~/.mycorporatebash/ directory
    rm -rf ~/.mycorporatebash/
    # Remove the script in /usr/local/bin
    rm /usr/local/bin/mycorporatebash
    echo "mycorporatebash has been uninstalled."
else
    echo "Uninstallation aborted."
fi
