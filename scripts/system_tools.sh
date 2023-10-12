#!/usr/bin/env sh

# Function to install XCode command line tools
install_xcode_tools() {
    # Check if XCode command line tools are already installed
    if ! xcode-select -p &>/dev/null; then
        printf "\033[1;36m==== Installing XCode Command Line Tools ====\033[0m\n"
        xcode-select --install
    else
        printf "\033[1;36mXCode Command Line Tools are already installed.\033[0m\n"
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
        printf "\033[1;36m==== Installing Rosetta ====\033[0m\n"
        softwareupdate --install-rosetta --agree-to-license
    else
        printf "\033[1;36mRosetta is already installed.\033[0m\n"
    fi
}

# Main function to run the installations
main() {
    install_xcode_tools
    install_rosetta
}

# Call the main function
main
