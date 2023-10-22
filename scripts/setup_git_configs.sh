#!/usr/bin/env sh

# Import our symlink functions
. "$(pwd)/scripts/symlink_functions.sh"

# Function to clear any broken symlinks in the specified directory
clear_broken_links_in_directory() {
    # Parameters:
    # $1: Directory to check and clear broken symlinks

    # Check if the directory argument is provided
    if [ -z "$1" ]; then
        print_error "Missing directory argument."
        return 1
    fi

    local dir="$1"

    print_message "Checking for broken symlinks in $dir"

    # Call the clear_broken_symlinks function
    clear_broken_symlinks "$dir"
}

# Function to symlink git configurations
setup_git_configs() {
    print_message "Setting up Git configurations"
    
    # Define the source and target paths for .gitconfig and .gitignore_global
    local gitconfig_source_path="$(pwd)/configs/git/.gitconfig"
    local gitconfig_target_path="$HOME/.gitconfig"
    local gitignore_global_source_path="$(pwd)/configs/git/.gitignore_global"
    local gitignore_global_target_path="$HOME/.gitignore_global"

    # Clear any broken symlinks in the home directory
    clear_broken_links_in_directory "$HOME"

    # Create symlinks
    create_symlink "$gitconfig_source_path" "$gitconfig_target_path"
    create_symlink "$gitignore_global_source_path" "$gitignore_global_target_path"
}

# Call the function
setup_git_configs
