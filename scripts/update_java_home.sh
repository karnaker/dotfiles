#!/usr/bin/env sh

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

# Function to discover the path to the Java SDK
get_java_sdk_path() {
    local java_sdk_path=$(find /Library/Java/JavaVirtualMachines -type d -name "zulu*.jdk" -print -quit)

    if [ -z "$java_sdk_path" ]; then
        print_error "Java SDK not found."
        exit 1
    fi

    echo "$java_sdk_path/Contents/Home"
}

# Function to update .zshrc with JAVA_HOME
update_java_home_in_dotfiles_zshrc() {
    local dotfiles_zshrc_path="$(pwd)/configs/zsh/.zshrc"

    if [ -f "$dotfiles_zshrc_path" ]; then
        local java_sdk_path=$(get_java_sdk_path)
        print_message "Java SDK found at: $java_sdk_path"

        # Check if the export JAVA_HOME line already exists
        if grep -q "export JAVA_HOME=" "$dotfiles_zshrc_path"; then
            # Update the existing line with the new value if necessary
            sed -i '' "s|export JAVA_HOME=.*|export JAVA_HOME=\"$java_sdk_path\"|" "$dotfiles_zshrc_path"
            print_message "JAVA_HOME already exists and has been updated to: $java_sdk_path"
        else
            # Add the export JAVA_HOME line if it doesn't exist
            echo "export JAVA_HOME=\"$java_sdk_path\"" >> "$dotfiles_zshrc_path"
            print_message "JAVA_HOME added to .zshrc: $java_sdk_path"
        fi

        # Check if the export PATH line already exists
        if grep -q "export PATH=\"\$JAVA_HOME/bin:\$PATH\"" "$dotfiles_zshrc_path"; then
            # Update the existing line with the new value if necessary
            sed -i '' "s|export PATH=\"\$JAVA_HOME/bin:\$PATH\"|export PATH=\"\$JAVA_HOME/bin:\$PATH\"|" "$dotfiles_zshrc_path"
            print_message "PATH already includes JAVA_HOME/bin"
        else
            # Add the export PATH line if it doesn't exist
            echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> "$dotfiles_zshrc_path"
            print_message "PATH updated to include JAVA_HOME/bin"
        fi

        print_message "JAVA_HOME and PATH updated in dotfiles .zshrc. Please restart your shell or run 'source $dotfiles_zshrc_path' for changes to take effect."
    else
        print_warning "Dotfiles .zshrc not found. You may need to manually update your shell configuration to set JAVA_HOME."
    fi
}

# Update JAVA_HOME in dotfiles .zshrc
update_java_home_in_dotfiles_zshrc
