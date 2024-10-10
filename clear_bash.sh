#!/bin/bash

# Check input argument
if [[ $# -ne 1 ]]; then
    echo "Usage : clear_bash <path_to_file>"
    exit 1
fi

profile_file="$1"
chaine="$HOME/.my-corporate-bash/run.sh"

# Check if given file path exists
if [[ ! -f "$profile_file" || ! -r "$profile_file" ]]; then
    echo "Error : provided profile_file '$profile_file' does not exists or cannot be read"
    exit 1
fi

# Check occurences and delete them
while grep -q "$chaine" "$profile_file"; do
    temp_file=$(mktemp)

    while IFS= read -r ligne; do
        if [[ "$ligne" != *"$chaine"* ]]; then
            echo "$ligne" >>"$temp_file"
        fi
    done <"$profile_file"

    mv "$temp_file" "$profile_file"
done
