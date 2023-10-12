#!/usr/bin/env sh

# Main bootstrap script

# Function to inform the user about the bootstrap start
start_bootstrap() {
    printf "\n\033[1;36m==== Starting the Bootstrap Process ====\033[0m\n"
}

# Function to grant execute permissions to scripts
grant_permissions() {
    printf "\033[1;36m==== Granting Execute Permissions to Scripts in ./scripts ====\033[0m\n"
    chmod +x scripts/*.sh
}

# Function to run the system tools installation script
run_system_tools() {
    printf "\033[1;36m==== Running System Tools Installation Script ====\033[0m\n"
    if [ -x scripts/system_tools.sh ]; then
        sh scripts/system_tools.sh
    else
        printf "\033[1;31mError: scripts/system_tools.sh does not have execute permissions or does not exist.\033[0m\n"
        exit 1
    fi
}

# Function to run the package installation script
run_install_packages() {
    printf "\033[1;36m==== Running Package Installation Script ====\033[0m\n"
    if [ -x scripts/install_packages.sh ]; then
        sh scripts/install_packages.sh
    else
        printf "\033[1;31mError: scripts/install_packages.sh does not have execute permissions or does not exist.\033[0m\n"
        exit 1
    fi
}

# Function to inform the user about the bootstrap completion
end_bootstrap() {
    printf "\n\033[1;36m==== Bootstrap Process Complete! ====\033[0m\n"
}

# Main function to run the bootstrap process
main() {
    start_bootstrap
    grant_permissions
    run_system_tools
    run_install_packages
    end_bootstrap
}

# Call the main function
main
