#!/usr/bin/env sh

# Main bootstrap script

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Function to inform the user about the bootstrap start
start_bootstrap() {
    printf "\n${CYAN}==== Starting the Bootstrap Process ====${RESET}\n"
}

# Function to prompt for sudo password at the beginning
prompt_for_password() {
    # Check if user is not root and then prompt for password
    if [ "$EUID" -ne 0 ]; then
        printf "${CYAN}Please enter your password for script execution${RESET}\n"
        sudo -v
        
        # Keep updating the sudo timestamp to avoid asking password again during execution
        while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    fi
}

# Function to grant execute permissions to scripts
grant_permissions() {
    printf "${CYAN}==== Granting Execute Permissions to Scripts in ./scripts ====${RESET}\n"
    chmod +x scripts/*.sh
}

# Function to run the system tools installation script
run_system_tools() {
    printf "${CYAN}==== Running System Tools Installation Script ====${RESET}\n"
    if [ -x scripts/system_tools.sh ]; then
        sh scripts/system_tools.sh
    else
        printf "${CYAN}Error: scripts/system_tools.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the package installation script
run_install_packages() {
    printf "${CYAN}==== Running Package Installation Script ====${RESET}\n"
    if [ -x scripts/install_packages.sh ]; then
        sh scripts/install_packages.sh
    else
        printf "${CYAN}Error: scripts/install_packages.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the Xcode configuration script
run_xcode_configuration() {
    printf "${CYAN}==== Running Xcode Configuration Script ====${RESET}\n"
    if [ -x scripts/configure_xcode.sh ]; then
        sh scripts/configure_xcode.sh
    else
        printf "${CYAN}Error: scripts/configure_xcode.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the git configuration setup script
run_git_config_setup() {
    printf "${CYAN}==== Running Git Configuration Setup Script ====${RESET}\n"
    if [ -x scripts/setup_git_configs.sh ]; then
        sh scripts/setup_git_configs.sh
    else
        printf "${CYAN}Error: scripts/setup_git_configs.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the iTerm2 configuration setup script
run_iterm2_config_setup() {
    printf "${CYAN}==== Running iTerm2 Configuration Setup Script ====${RESET}\n"
    # Check if the script has execute permissions and exists
    if [ -x scripts/setup_iterm2_configs.sh ]; then
        sh scripts/setup_iterm2_configs.sh
    else
        printf "${CYAN}Error: scripts/setup_iterm2_configs.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the macOS configuration script
run_macos_config() {
    printf "${CYAN}==== Running macOS Configuration Script ====${RESET}\n"
    # Check if the script has execute permissions and exists
    if [ -x scripts/macos_config.sh ]; then
        sh scripts/macos_config.sh
    else
        printf "${CYAN}Error: scripts/macos_config.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the Zsh configuration setup script
run_zsh_config_setup() {
    printf "${CYAN}==== Running Zsh Configuration Setup Script ====${RESET}\n"
    # Check if the script has execute permissions and exists
    if [ -x scripts/setup_zsh_configs.sh ]; then
        sh scripts/setup_zsh_configs.sh
    else
        printf "${CYAN}Error: scripts/setup_zsh_configs.sh does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to run the VS Code configuration setup script
run_vscode_config_setup() {
    # Print a message to inform the user about the VS Code setup process
    printf "${CYAN}==== Running VS Code Configuration Setup Script ====${RESET}\n"

    # Define the path to the VS Code setup script
    local vscode_setup_script="scripts/setup_vscode_configs.sh"

    # Check if the script has execute permissions and exists
    if [ -x "$vscode_setup_script" ]; then
        # Execute the VS Code setup script
        sh "$vscode_setup_script"

        # Check the exit status of the last command
        if [ $? -ne 0 ]; then
            # Print an error message if the script execution fails
            printf "${CYAN}Error: Failed to execute $vscode_setup_script.${RESET}\n"
            exit 1
        fi
    else
        # Print an error message if the script does not have execute permissions or does not exist
        printf "${CYAN}Error: $vscode_setup_script does not have execute permissions or does not exist.${RESET}\n"
        exit 1
    fi
}

# Function to inform the user about the bootstrap completion
end_bootstrap() {
    printf "\n${CYAN}==== Bootstrap Process Complete! ====${RESET}\n"
}

# Main function to run the bootstrap process
main() {
    start_bootstrap
    prompt_for_password
    grant_permissions
    run_system_tools
    run_install_packages
    run_xcode_configuration
    run_git_config_setup
    run_iterm2_config_setup
    run_macos_config
    run_zsh_config_setup
    run_vscode_config_setup
    end_bootstrap
}

# Call the main function
main
