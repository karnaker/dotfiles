#!/usr/bin/env bash

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

# Function to verify the existence of the 1Password CLI plugins.sh file
verify_op_plugins() {
    local plugins_file="/Users/vikram/.config/op/plugins.sh"

    # Check if the plugins.sh file exists
    if [ -f "$plugins_file" ]; then
        print_message "Verification successful: Found plugins.sh file at $plugins_file."
    else
        print_error "plugins.sh file not found at $plugins_file. Please ensure 1Password CLI is correctly configured."
        exit 1
    fi
}

# Call the function to verify the existence of the plugins.sh file
verify_op_plugins
