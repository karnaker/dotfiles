#!/usr/bin/env sh

# This script handles the installation of software packages.

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Paths
BREWFILE_PATH="$(pwd)/configs/packages/Brewfile"

# Function to check if a command exists
# $1: Command to check
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
    # Check if Homebrew is already installed
    if ! command_exists brew; then
        printf "${CYAN}==== Installing Homebrew ====${RESET}\n"
        
        # Use /bin/bash to execute the Homebrew installation script
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Function to update Homebrew
update_homebrew() {
    printf "${CYAN}==== Updating Homebrew Recipes ====${RESET}\n"
    brew update
}

# Function to upgrade formulae
upgrade_formulae() {
    printf "${CYAN}==== Upgrading Installed Formulae ====${RESET}\n"
    brew upgrade
}

# Function to run brew bundle
run_brew_bundle() {
    printf "${CYAN}==== Installing Packages from Brewfile ====${RESET}\n"
    
    # Check if the Brewfile exists
    if [ -f "$BREWFILE_PATH" ]; then
        brew bundle --file="$BREWFILE_PATH"
    else
        printf "${CYAN}Error: Brewfile does not exist at $BREWFILE_PATH.${RESET}\n"
        exit 1
    fi
}

# Function to ensure the latest npm version
ensure_latest_npm() {
    printf "${CYAN}==== Ensuring the Latest NPM Version ====${RESET}\n"
    
    # Check if node is installed
    if command_exists node; then
        npm install -g npm
    else
        printf "${CYAN}Error: Node is not installed. Cannot update NPM.${RESET}\n"
        exit 1
    fi
}

# Main function to orchestrate the package installation
install_packages() {
    # Inform the user that the installation process is starting
    printf "\n${CYAN}==== Starting the Package Installation Process ====${RESET}\n"
    
    install_homebrew
    update_homebrew
    upgrade_formulae
    run_brew_bundle
    ensure_latest_npm

    # Inform the user that the installation process is complete
    printf "\n${CYAN}==== Package Installation Complete! ====${RESET}\n"
}

# Call the main function
install_packages
