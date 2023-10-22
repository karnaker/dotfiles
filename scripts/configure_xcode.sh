#!/usr/bin/env sh

# This script configures Xcode

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

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
            print_message "Configuring Xcode Command Line Tools"
            
            # Set Xcode command-line tools to use the newly-installed version of Xcode
            sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
            sudo xcodebuild -runFirstLaunch
            
            # Inform the user about the automatic license acceptance
            print_message "Automatically accepting Xcode license"
            
            # Accept the Xcode license
            echo | sudo xcodebuild -license accept
            
            print_message "Xcode configuration complete."
        else
            print_message "Xcode has already been configured."
        fi
    else
        print_error "Xcode is not installed. Please install Xcode first."
    fi
}

# Call the configuration function
configure_xcode
