#!/usr/bin/env sh

# This script configures Xcode

# Function to check if Xcode is installed
is_xcode_installed() {
    [ -d "/Applications/Xcode.app" ]
}

# Function to check if Xcode has been configured
is_xcode_configured() {
    sudo xcodebuild -checkFirstLaunchStatus &>/dev/null
}

# Function to configure Xcode
configure_xcode() {
    # Check if Xcode is installed
    if is_xcode_installed; then
        # Check if Xcode has already been configured
        if ! is_xcode_configured; then
            printf "\033[1;36m==== Configuring Xcode Command Line Tools ====\033[0m\n"
            
            # Set Xcode command-line tools to use the newly-installed version of Xcode
            sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
            sudo xcodebuild -runFirstLaunch
            
            # Inform the user about the automatic license acceptance
            printf "\033[1;36mAutomatically accepting Xcode license...\033[0m\n"
            
            # Accept the Xcode license
            echo | sudo xcodebuild -license accept
            
            printf "\033[1;36mXcode configuration complete.\033[0m\n"
        else
            printf "\033[1;36mXcode has already been configured.\033[0m\n"
        fi
    else
        printf "\033[1;31mXcode is not installed. Please install Xcode first.\033[0m\n"
    fi
}

# Call the configuration function
configure_xcode
