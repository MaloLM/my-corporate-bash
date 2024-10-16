#!/bin/bash

# Check that the parameters are passed
if [ -z "$0" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Error: One or more parameters are missing."
    echo "Usage: run.sh <image_path> <proportion> <color>"
    exit 1
fi

image_path=$1
proportion=$2
color=$3

# Calculate the target width (coefficient * width of the window) and round down to the nearest integer
terminal_width=$(tput cols)
target_width=$(echo "scale=0; $terminal_width * $proportion / 1" | bc)

if command -v ascii-image-converter &>/dev/null; then
    if [[ "$color" == "true" ]]; then
        ascii-image-converter "$image_path" -W "$target_width" -C
    elif [[ "$color" == "false" ]]; then
        ascii-image-converter "$image_path" -W "$target_width"
    else
        echo "my-corporate-bash failed displaying the init image."
    fi
else
    echo "my-corporate-bash failed displaying the init image."
fi
