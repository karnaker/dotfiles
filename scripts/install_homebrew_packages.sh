#!/usr/bin/env sh

# This script handles the installation of Homebrew software packages.

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

# Paths
BREWFILE_PATH="$(pwd)/configs/homebrew/Brewfile"

# Function to check if a command exists
# $1: Command to check
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
    # Check if Homebrew is already installed
    if ! command_exists brew; then
        print_message "Installing Homebrew"
        
        # Use /bin/bash to execute the Homebrew installation script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Function to update Homebrew
update_homebrew() {
    print_message "Updating Homebrew Recipes"
    brew update
}

# Function to upgrade formulae
upgrade_formulae() {
    print_message "Upgrading Installed Formulae"
    brew upgrade
}

# Function to run brew bundle
run_brew_bundle() {
    print_message "Installing Packages from Brewfile"
    
    # Check if the Brewfile exists
    if [ -f "$BREWFILE_PATH" ]; then
        brew bundle --file="$BREWFILE_PATH"
    else
        print_error "Brewfile does not exist at $BREWFILE_PATH."
        exit 1
    fi
}

# Function to clean up Homebrew
cleanup_homebrew() {
    print_message "Cleaning up Homebrew"
    brew cleanup
}

# Main function to orchestrate the package installation
install_homebrew_packages() {
    # Inform the user that the installation process is starting
    print_message "Starting the Package Installation Process"
    
    install_homebrew
    update_homebrew
    upgrade_formulae
    run_brew_bundle
    cleanup_homebrew

    # Inform the user that the installation process is complete
    print_message "Package Installation Complete!"
}

# Call the main function
install_homebrew_packages
