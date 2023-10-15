#!/usr/bin/env sh

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Function to create symbolic links
create_symlink() {
    # Parameters:
    # $1: Source file or directory
    # $2: Target file or directory

    # Check if both arguments are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        printf "${CYAN}Error: Missing arguments. Provide both source and target paths.${RESET}\n"
        return 1
    fi

    local source_path="$1"
    local target_path="$2"

    # Check if the source path exists
    if [ ! -e "$source_path" ]; then
        printf "${CYAN}Error: Source path does not exist: $source_path${RESET}\n"
        return 1
    fi

    # If the target path already exists
    if [ -e "$target_path" ]; then
        # If it's a symlink, remove it
        if [ -L "$target_path" ]; then
            printf "${CYAN}Removing existing symlink at $target_path${RESET}\n"
            rm "$target_path"
            if [ ! -L "$target_path" ]; then
                printf "${CYAN}Successfully removed symlink at $target_path${RESET}\n"
            else
                printf "${CYAN}Failed to remove symlink at $target_path${RESET}\n"
                return 1
            fi
        else
            # If not a symlink, back it up
            local backup_dir="$(dirname "$target_path")/backup"
            local backup_file="$backup_dir/$(basename "$target_path")_$(date +%F_%T)"
            printf "${CYAN}Backing up existing file/directory at $target_path to $backup_file${RESET}\n"
            mkdir -p "$backup_dir"
            mv "$target_path" "$backup_file"
            if [ ! -e "$target_path" ] && [ -e "$backup_file" ]; then
                printf "${CYAN}Successfully backed up to $backup_file${RESET}\n"
            else
                printf "${CYAN}Failed to backup $target_path${RESET}\n"
                return 1
            fi
        fi
    fi

    # Create the symlink
    ln -s "$source_path" "$target_path"
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        printf "${CYAN}Successfully created symlink: $target_path -> $source_path${RESET}\n"
    else
        printf "${CYAN}Failed to create symlink from $target_path to $source_path${RESET}\n"
        return 1
    fi
}
