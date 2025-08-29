#!/usr/bin/env sh

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

# Function to install nvm (Node Version Manager)
install_nvm() {
    print_message "Installing NVM (Node Version Manager)"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
}

# Function to install the latest LTS version of Node.js using nvm
install_latest_lts_node() {
    print_message "Installing the Latest LTS Version of Node.js using NVM"

    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install the latest LTS version
    nvm install --lts
    nvm use --lts
}

# Main function to manage the installation process
install_nvm_and_node() {
    install_nvm
    install_latest_lts_node

    print_message "NVM and Node.js Installation Complete"
}

# Call the main function
install_nvm_and_node
