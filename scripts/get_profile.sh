#!/bin/bash

# Get current shell user
USER_SHELL=$(echo $SHELL)

# Determine which bash profile file based on current shell
case "$USER_SHELL" in
*/bash)
    if [[ -f "$HOME/.bash_profile" ]]; then
        USER_PROFILE="$HOME/.bash_profile"
    elif [[ -f "$HOME/.bashrc" ]]; then
        USER_PROFILE="$HOME/.bashrc"
    else
        USER_PROFILE="$HOME/.profile"
    fi
    ;;
*/zsh)
    USER_PROFILE="$HOME/.zshrc"
    ;;
*/fish)
    USER_PROFILE="$HOME/.config/fish/config.fish"
    ;;
*/ksh)
    USER_PROFILE="$HOME/.kshrc"
    ;;
*/csh | */tcsh)
    USER_PROFILE="$HOME/.cshrc"
    ;;
*)
    echo "Unsupported shell or unknown profile file: $USER_SHELL"
    exit 1
    ;;
esac

echo "$USER_PROFILE"
