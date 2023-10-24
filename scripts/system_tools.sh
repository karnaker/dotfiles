#!/usr/bin/env sh

# Import our print functions
. "$(pwd)/scripts/print_functions.sh"

# Function to install XCode command line tools
install_xcode_tools() {
    # Check if XCode command line tools are already installed
    if ! xcode-select -p &>/dev/null; then
        print_message "Installing XCode Command Line Tools"
        xcode-select --install
    else
        print_message "XCode Command Line Tools are already installed."
    fi
}

# Function to check if Rosetta is installed
is_rosetta_installed() {
    # Look for a specific directory that Rosetta uses
    [ -d "/Library/Apple/usr/share/rosetta" ]
}

# Function to install Rosetta (only on M1 Macs)
install_rosetta() {
    # Check if Rosetta is already installed
    if ! is_rosetta_installed; then
        print_message "Installing Rosetta"
        softwareupdate --install-rosetta --agree-to-license
    else
        print_message "Rosetta is already installed."
    fi
}

# Main function to run the installations
main() {
    install_xcode_tools
    install_rosetta
}

# Call the main function
main
