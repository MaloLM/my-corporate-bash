#!/bin/bash

function clear_bash {
    # Check input argument
    if [[ $# -ne 1 ]]; then
        echo "Usage : clear_bash <path_to_file>"
        exit 1
    fi

    fichier="$1"
    chaine="/Users/malo/.mycorporatebash/run.sh"

    # check if given file path exists
    if [[ ! -f "$fichier" || ! -r "$fichier" ]]; then
        echo "Erreur : le fichier '$fichier' n'existe pas ou n'est pas lisible."
        exit 1
    fi

    # Check occurences and delete them
    while grep -q "$chaine" "$fichier"; do
        temp_file=$(mktemp)

        while IFS= read -r ligne; do
            if [[ "$ligne" != *"$chaine"* ]]; then
                echo "$ligne" >>"$temp_file"
            fi
        done <"$fichier"

        mv "$temp_file" "$fichier"
    done
}

function finish_setup {
    # Build the line to be added to the profile file
    run_command="$HOME/.mycorporatebash/run.sh ~/.mycorporatebash/base_image.${image_path##*.} $proportion $color"

    clear_bash $profile_file

    # Add the new line to the end of the profile file
    echo "$run_command" >>"$profile_file"

    printf "Setup completed. Please restart your terminal session or run 'source %s' to apply changes.\n" "$profile_file"
}

function get_profile_file {
    local shell_name=$(basename "$SHELL")
    local profile_file

    if [[ "$shell_name" == "bash" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            profile_file=~/.bash_profile
        else
            profile_file=~/.bashrc
        fi
    elif [[ "$shell_name" == "zsh" ]]; then
        profile_file=~/.zshrc
    else
        echo "Unsupported shell: $shell_name. Please manually add ~/.mycorporatebash/run.sh to your shell profile."
        exit 1
    fi

    echo "$profile_file" # Return the path of the profile file
}

function save_bash_profile {
    profile_file=$(get_profile_file)

    # Get the filename without the path
    base_name=$(basename "$profile_file")

    # Create the new filename
    new_file_name="${base_name}_copy"

    # Make a copy of the profile file in the ~/.mycorporatebash/ directory with the new name
    cp "$profile_file" "$HOME/.mycorporatebash/$new_file_name"

    printf '\n'
    echo "Backup of $profile_file saved to $HOME/.mycorporatebash/$new_file_name"
}

# Check the arguments
image_path=""
proportion="0.95" # Default value
color="no"        # Default value for when no color is passed

# Parse the arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
    -P)
        if [[ -n "$2" && ! "$2" =~ ^- ]]; then
            proportion="$2"
            shift 2
        else
            echo "Error: Option -P requires a value."
            exit 1
        fi
        ;;
    -C)
        color="yes"
        # If the next argument is not empty and is not a flag, skip it
        if [[ -n "$2" && ! "$2" =~ ^- ]]; then
            shift 2
        else
            shift
        fi
        ;;
    *)
        # Ensure that this is a valid image path
        if [[ -z "$image_path" ]]; then
            image_path="$2"
        fi
        shift
        ;;
    esac
done

# Check the image path
if [[ -z "$image_path" ]]; then
    echo "Error: No image path provided."
    exit 1
fi

# Check if the image file exists
if [[ ! -f "$image_path" ]]; then
    echo "Error: Image file not found at the specified path."
    exit 1
fi

# Check for supported image formats
if [[ ! "$image_path" =~ \.(jpeg|jpg|png|bmp|webp|tiff|tif)$ ]]; then
    echo "Error: Unsupported image format. Supported formats are JPEG, JPG, PNG, BMP, WEBP, TIFF."
    exit 1
fi

# Validate the proportion (must be between 0 and 1)
if (($(echo "$proportion < 0" | bc -l))) || (($(echo "$proportion > 1" | bc -l))); then
    echo "Error: Proportion must be a value between 0 and 1."
    exit 1
fi

# Check if ascii-image-converter is installed
if ! command -v ascii-image-converter &>/dev/null; then
    echo "Error: ascii-image-converter is not installed. Please install it first."
    exit 1
fi

# Backup the bash profile
save_bash_profile

# Copy the image to ~/.mycorporatebash/ with a fixed name
mkdir -p "$HOME"/.mycorporatebash/
cp "$image_path" "$HOME"/.mycorporatebash/base_image."${image_path##*.}"

# Determine the bash/zsh profile file
shell_name=$(basename "$SHELL")

if [[ "$shell_name" == "bash" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        profile_file=~/.bash_profile
    else
        profile_file=~/.bashrc
    fi
elif [[ "$shell_name" == "zsh" ]]; then
    profile_file=~/.zshrc
else
    echo "Unsupported shell: $shell_name. Please manually add ~/.mycorporatebash/run.sh to your shell profile."
    exit 1
fi

# Test
"$HOME"/.mycorporatebash/run.sh ~/.mycorporatebash/base_image."${image_path##*.}" "$proportion" $color

printf "\n"
read -r -p "Are you satisfyed with this displaying? (y/n): " confirm

# Convert the response to lowercase for easier verification
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ $confirm == "y" || $confirm == "yes" ]]; then
    finish_setup
else
    printf "\nSetup aborted.\n"
fi
