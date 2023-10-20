#!/usr/bin/env sh

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Import our symlink functions
. scripts/symlink_functions.sh

# Function to symlink VS Code configuration files
symlink_vscode_settings() {
    # Define the source and target paths
    local settings_source_path="$(pwd)/configs/vscode/settings.json"
    local settings_target_dir="$HOME/Library/Application Support/Code/User"
    local settings_target_path="$settings_target_dir/settings.json"

    # Check if the target directory exists
    if [ ! -d "$settings_target_dir" ]; then
        printf "${CYAN}Warning: Target directory does not exist: $settings_target_dir. Skipping VS Code configuration.${RESET}\n"
        return
    fi
    
    # Clear any broken symlinks in the target directory
    clear_broken_symlinks "$(dirname "$settings_target_path")"

    # Create a symlink for settings.json
    create_symlink "$settings_source_path" "$settings_target_path"
}

# Function to install VS Code extensions from extensions.txt
install_vscode_extensions() {
    # Define the path to the extensions list file
    local extensions_list_file="$(pwd)/configs/vscode/extensions.txt"
    
    # Check if the extensions list file exists
    if [ ! -f "$extensions_list_file" ]; then
        printf "${CYAN}Warning: Extensions list file not found: $extensions_list_file. Skipping extension installation.${RESET}\n"
        return
    fi

    # Read the list of extensions from the file and install them
    while IFS= read -r extension; do
        if [ -n "$extension" ]; then
            printf "${CYAN}Installing VS Code extension: $extension${RESET}\n"
            if code --install-extension "$extension"; then
                printf "${CYAN}Successfully installed: $extension${RESET}\n"
            else
                printf "${CYAN}Failed to install: $extension${RESET}\n"
            fi
        fi
    done < "$extensions_list_file"
}

# Main function for configuring VS Code
main() {
    symlink_vscode_settings
    install_vscode_extensions
}

# Call the main function
main
