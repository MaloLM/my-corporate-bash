#!/bin/bash

# Variable assignment
profile_file=$("$HOME/.my-corporate-bash/get_profile.sh")
chaine=".my-corporate-bash/run.sh"

# Check if the profile_file exists and is readable
if [[ ! -f "$profile_file" || ! -r "$profile_file" ]]; then
    echo "Error: the profile_file '$profile_file' does not exist or cannot be read"
    exit 1
fi

# Create a temporary profile_file
temp_file=$(mktemp)

# Iterate through the profile_file line by line
while IFS= read -r line; do
    if [[ "$line" == *"$chaine"* ]]; then
        # If the line starts with a '#', remove it
        if [[ "$line" == "#"* ]]; then
            echo "${line#"#"}" >>"$temp_file"
        else
            echo "$line" >>"$temp_file"
        fi
    else
        # If the line does not contain the string, add it as is
        echo "$line" >>"$temp_file"
    fi
done <"$profile_file"

# Replace the old profile_file with the temporary profile_file
mv "$temp_file" "$profile_file"
