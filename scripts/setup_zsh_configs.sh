#!/usr/bin/env sh

# Import our symlink functions
. "$(pwd)/scripts/symlink_functions.sh"

# Function to install Oh My Zsh if not already installed
install_oh_my_zsh() {
    local oh_my_zsh_dir="$HOME/.oh-my-zsh"
    
    # Check if Oh My Zsh is already installed
    if [ -d "$oh_my_zsh_dir" ]; then
        print_message "Oh My Zsh is already installed."
        return
    fi
    
    print_message "Installing Oh My Zsh..."
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        print_error "Oh My Zsh installation failed."
        exit 1
    fi
}

# Function to symlink the .zshrc file
symlink_zshrc() {
    # Define the source and target paths
    local zsh_source_path="$(pwd)/configs/zsh/.zshrc"
    local zsh_target_path="$HOME/.zshrc"
    
    # Clear any broken symlinks in the target directory
    clear_broken_symlinks "$(dirname "$zsh_target_path")"

    # Create a symlink for .zshrc
    create_symlink "$zsh_source_path" "$zsh_target_path"
}

# Main function for configuring Zsh
main() {
    install_oh_my_zsh
    symlink_zshrc
}

# Call the main function
main
