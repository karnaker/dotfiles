#!/usr/bin/env sh

# This script handles the installation of software packages

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

# Function to tap repositories
tap_repositories() {
    printf "\033[1;36m==== Tapping Necessary Repositories ====\033[0m\n"
    brew tap heroku/brew
    brew tap mongodb/brew
}

# Function to install cask software
install_cask_software() {
    printf "\033[1;36m==== Installing Cask Software ====\033[0m\n"
    brew install --cask 1password adobe-acrobat-pro adobe-acrobat-reader android-studio discord docker exodus expressvpn flutter google-chrome google-drive iterm2 krita ledger-live mongodb-compass ngrok paintbrush rectangle slack visual-studio-code vlc zoom
}

# Function to install formulae
install_formulae() {
    printf "\033[1;36m==== Installing Formulae ====\033[0m\n"
    brew install cocoapods coreutils git heroku mas mongodb-community node redis
}

# Function to install MAS software
install_mas_software() {
    printf "\033[1;36m==== Installing Mac App Store Software ====\033[0m\n"
    mas install 682658836 # GarageBand
    mas install 408981434 # iMovie
    mas install 497799835 # Xcode
}

# Main function to orchestrate the package installation
install_packages() {
    # Inform the user that the installation process is starting
    printf "\n\033[1;36m==== Starting the Package Installation Process ====\033[0m\n"
    
    install_homebrew
    update_homebrew
    upgrade_formulae
    tap_repositories
    install_cask_software
    install_formulae
    install_mas_software

    # Inform the user that the installation process is complete
    printf "\n\033[1;36m==== Package Installation Complete! ====\033[0m\n"
}

# Call the main function
install_packages
