#!/bin/bash

function show_help {
    echo "Usage: my-corporate-bash [command]"
    echo ""
    echo "Commands:"
    echo "  setup [image] -P [proportion] -C [color]    Setup the image to display"
    echo "  enable                                      enable the setup image from bash session startup"
    echo "  disable                                     disable the setup image. It is still setup, but hidden at bash session startup. Enable to display back"
    echo "  uninstall                                   Uninstall the application"
    echo "  --help | -h                                 Display this help message"
}

function help_setup {
    echo "Usage: my-corporate-bash setup image_path [options]"
    echo "Set up the environment with necessary configurations."
    echo "Options:"
    echo "  -h, --help  Display help for setup."
    echo "  -P value    Proportion between 0 and 1 of the terminal width used."
    echo "  -C          Keep colors from source image."
}

function help_disable {
    echo "Usage: my-corporate-bash disable"
    echo "Disables (hide) the disaplaying of the setup image at bash session startup."
}

function help_enable {
    echo "Usage: my-corporate-bash enable"
    echo "Enables the disaplaying of the setup image at bash session startup."
}

function help_uninstall {
    echo "Usage: my-corporate-bash uninstall"
    echo "Sudo privileges will be requested during proceed."
    echo "Uninstall the app from system."
}

function setup {
    "$HOME"/.my-corporate-bash/setup.sh "$@"
}

function uninstall {
    "$HOME"/.my-corporate-bash/uninstall.sh
}

function enable {
    "$HOME"/.my-corporate-bash/enable.sh
}

function disable {
    "$HOME"/.my-corporate-bash/disable.sh
}

COMMAND=$1

case "$COMMAND" in
setup)
    if [[ "$2" == "-h" || "$2" == "--help" ]]; then
        help_setup
        exit 0
    fi
    setup "$@"
    ;;
enable)
    if [[ "$2" == "-h" || "$2" == "--help" ]]; then
        help_enable
        exit 0
    fi
    enable
    ;;
disable)
    if [[ "$2" == "-h" || "$2" == "--help" ]]; then
        help_disable
        exit 0
    fi
    disable
    ;;
uninstall)
    if [[ "$2" == "-h" || "$2" == "--help" ]]; then
        help_uninstall
        exit 0
    fi
    uninstall
    ;;
--help | -h)
    show_help
    ;;
install)
    echo "mycorparatebash is already installed."
    ;;
*)
    echo "Invalid command. Use --help for usage information."
    exit 1
    ;;
esac
