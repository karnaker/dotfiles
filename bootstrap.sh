#!/usr/bin/env sh

# TODO Create a font function script that can be used by other scripts to output text in a uniform way.
# TODO Update README to include steps from clean machine, before bootstrap.sh is run. Guide on Mac wizard. Do I need to install git? Etc.

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
    chmod +x "$(pwd)/scripts/"*.sh
}

# Function to execute a given script
execute_script() {
    local script_name="$1"
    local script_path="$(pwd)/scripts/$script_name"

    printf "${CYAN}==== Running $script_name ====${RESET}\n"

    # Check if the script has execute permissions and exists
    if [ -x "$script_path" ]; then
        sh "$script_path"
        # Check the exit status of the script
        if [ $? -ne 0 ]; then
            printf "${CYAN}Error: Failed to execute $script_path.${RESET}\n"
            exit 1
        fi
    else
        printf "${CYAN}Error: $script_path does not have execute permissions or does not exist.${RESET}\n"
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
    execute_script "system_tools.sh"
    execute_script "install_packages.sh"
    execute_script "configure_xcode.sh"
    execute_script "setup_git_configs.sh"
    execute_script "setup_iterm2_configs.sh"
    execute_script "macos_config.sh"
    execute_script "setup_zsh_configs.sh"
    execute_script "setup_vscode_configs.sh"
    execute_script "clone_repositories.sh"
    end_bootstrap
}

# Call the main function
main
