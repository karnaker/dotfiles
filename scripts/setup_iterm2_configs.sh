#!/usr/bin/env sh

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Import our symlink functions
. scripts/symlink_functions.sh

# Variables for theme setup
THEME_URL="https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors"
LOCAL_THEME_PATH="$(pwd)/configs/iterm2/themes/material-design-colors.itermcolors"
TEMP_THEME_PATH="$(pwd)/tmp/material-design-colors.itermcolors"

# Function to download iTerm2 theme
download_theme() {
    mkdir -p "$(dirname "$TEMP_THEME_PATH")"  # Ensure tmp directory exists

    # Download theme to temporary location
    curl -fsSL "$THEME_URL" -o "$TEMP_THEME_PATH"

    # Check the exit status of curl
    if [ $? -ne 0 ]; then
        printf "${CYAN}Error: Failed to download theme from $THEME_URL${RESET}\n"
        exit 1
    fi
}

# Function to check and update iTerm2 theme
update_iterm2_theme() {
    # If local theme doesn't exist, download it
    if [ ! -f "$LOCAL_THEME_PATH" ]; then
        printf "${CYAN}Local theme not found. Downloading...${RESET}\n"
        download_theme
        mv "$TEMP_THEME_PATH" "$LOCAL_THEME_PATH"
        printf "${CYAN}Theme downloaded successfully to $LOCAL_THEME_PATH${RESET}\n"
        return
    fi

    # Compare local theme with remote theme
    download_theme
    diff "$TEMP_THEME_PATH" "$LOCAL_THEME_PATH" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        printf "${CYAN}Theme at URL has new changes. Updating local theme...${RESET}\n"
        mv "$TEMP_THEME_PATH" "$LOCAL_THEME_PATH"
        printf "${CYAN}Theme updated successfully to $LOCAL_THEME_PATH${RESET}\n"
    else
        printf "${CYAN}Local theme is up-to-date. No changes detected.${RESET}\n"
    fi

    # Clean up the tmp directory
    rm -rf "$(dirname "$TEMP_THEME_PATH")"
}

# Function to symlink iTerm2 profile
setup_iterm2_profile() {
    local PROFILE_SOURCE_PATH="$(pwd)/configs/iterm2/iterm2_profile_base.json"
    local PROFILE_TARGET_PATH="$HOME/Library/Application Support/iTerm2/DynamicProfiles/iterm2_profile_base.json"

    # Clear broken symlinks in the target directory
    clear_broken_symlinks "$(dirname "$PROFILE_TARGET_PATH")"

    # Symlink the profile
    create_symlink "$PROFILE_SOURCE_PATH" "$PROFILE_TARGET_PATH"
}

# Main function to set up iTerm2 configurations
setup_iterm2_configs() {
    update_iterm2_theme
    setup_iterm2_profile
}

# Call the main function
setup_iterm2_configs
