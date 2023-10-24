#!/usr/bin/env sh

# Import our print functions
. "$(pwd)/scripts/print_functions.sh"

# Main bootstrap script

# Function to inform the user about the bootstrap start
start_bootstrap() {
    print_message "Starting the Bootstrap Process"
}

# Function to prompt for sudo password at the beginning
prompt_for_password() {
    # Check if user is not root and then prompt for password
    if [ "$EUID" -ne 0 ]; then
        print_message "Please enter your password for script execution"
        sudo -v
        # Keep updating the sudo timestamp to avoid asking password again during execution
        while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    fi
}

# Function to grant execute permissions to scripts
grant_permissions() {
    print_message "Granting Execute Permissions to Scripts in ./scripts"
    chmod +x "$(pwd)/scripts/"*.sh
}

# Function to execute a given script
execute_script() {
    local script_name="$1"
    local script_path="$(pwd)/scripts/$script_name"

    print_message "Running $script_name"

    # Check if the script has execute permissions and exists
    if [ -x "$script_path" ]; then
        sh "$script_path"
        # Check the exit status of the script
        if [ $? -ne 0 ]; then
            print_error "Failed to execute $script_path."
            exit 1
        fi
    else
        print_error "$script_path does not have execute permissions or does not exist."
        exit 1
    fi
}

# Function to inform the user about the bootstrap completion
end_bootstrap() {
    print_message "Bootstrap Process Complete!"
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
