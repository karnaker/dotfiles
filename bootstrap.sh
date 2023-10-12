#!/usr/bin/env sh

# Main bootstrap script

# Function to inform the user about the bootstrap start
start_bootstrap() {
    echo -e "\n\033[1;36m==== Starting the Bootstrap Process ====\033[0m\n"
}

# Function to grant execute permissions to scripts
grant_permissions() {
    echo -e "\033[1;36m==== Granting Execute Permissions to Scripts in ./scripts ====\033[0m"
    chmod +x scripts/*.sh
}

# Function to run the package installation script
run_install_packages() {
    echo -e "\033[1;36m==== Running Package Installation Script ====\033[0m"
    if [ -x scripts/install_packages.sh ]; then
        sh scripts/install_packages.sh
    else
        echo -e "\033[1;31mError: scripts/install_packages.sh does not have execute permissions or does not exist.\033[0m"
        exit 1
    fi
}

# Function to inform the user about the bootstrap completion
end_bootstrap() {
    echo -e "\n\033[1;36m==== Bootstrap Process Complete! ====\033[0m\n"
}

# Main function to run the bootstrap process
main() {
    start_bootstrap
    grant_permissions
    run_install_packages
    end_bootstrap
}

# Call the main function
main
