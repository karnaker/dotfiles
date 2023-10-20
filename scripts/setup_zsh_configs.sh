#!/usr/bin/env sh

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Import our symlink functions
. scripts/symlink_functions.sh

# Function to install Oh My Zsh if not already installed
install_oh_my_zsh() {
    local oh_my_zsh_dir="$HOME/.oh-my-zsh"
    
    # Check if Oh My Zsh is already installed
    if [ -d "$oh_my_zsh_dir" ]; then
        printf "${CYAN}Oh My Zsh is already installed.${RESET}\n"
        return
    fi
    
    printf "${CYAN}Installing Oh My Zsh...${RESET}\n"
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        printf "${CYAN}Error: Oh My Zsh installation failed.${RESET}\n"
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
