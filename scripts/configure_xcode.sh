#!/usr/bin/env sh

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
        
        # Call the function to install and update iOS Simulator
        install_and_update_ios_simulator
    else
        print_error "Xcode is not installed. Please install Xcode first."
    fi
}

# Function to check if iOS Simulator is installed
is_ios_simulator_installed() {
    # Check if the iOS Simulator is already installed
    [ -d "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform" ]
}

# Function to install and update the iOS Simulator
install_and_update_ios_simulator() {
    # Check if the iOS Simulator is already installed
    if ! is_ios_simulator_installed; then
        print_message "iOS Simulator is not installed."
    else
        print_message "iOS Simulator is already installed."
    fi
    
    # Update the iOS Simulator to the latest version
    print_message "Downloading and installing latest version of iOS Simulator."
    xcodebuild -downloadPlatform iOS
}

# Call the configure_xcode function
configure_xcode
