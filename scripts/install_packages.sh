#!/usr/bin/env sh

# This script handles the installation of software packages

# Paths
BREWFILE_PATH="scripts/Brewfile"

# Function to install Homebrew
install_homebrew() {
    if [ ! $(which brew) ]; then
        printf "\033[1;36m==== Installing Homebrew ====\033[0m\n"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Function to update Homebrew
update_homebrew() {
    printf "\033[1;36m==== Updating Homebrew Recipes ====\033[0m\n"
    brew update
}

# Function to upgrade formulae
upgrade_formulae() {
    printf "\033[1;36m==== Upgrading Installed Formulae ====\033[0m\n"
    brew upgrade
}

# Function to run brew bundle
run_brew_bundle() {
    printf "\033[1;36m==== Installing Packages from Brewfile ====\033[0m\n"
    if [ -f "$BREWFILE_PATH" ]; then
        brew bundle --file="$BREWFILE_PATH"
    else
        printf "\033[1;31mError: Brewfile does not exist at $BREWFILE_PATH.\033[0m\n"
        exit 1
    fi
}

# Main function to orchestrate the package installation
install_packages() {
    # Inform the user that the installation process is starting
    printf "\n\033[1;36m==== Starting the Package Installation Process ====\033[0m\n"
    
    install_homebrew
    update_homebrew
    upgrade_formulae
    run_brew_bundle

    # Inform the user that the installation process is complete
    printf "\n\033[1;36m==== Package Installation Complete! ====\033[0m\n"
}

# Call the main function
install_packages
