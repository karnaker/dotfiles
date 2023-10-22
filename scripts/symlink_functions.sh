#!/usr/bin/env sh

# Import other scripts
. "$(pwd)/scripts/print_functions.sh"

# Function to create symbolic links
create_symlink() {
    # Parameters:
    # $1: Source file or directory
    # $2: Target file or directory

    # Check if both arguments are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        print_error "Missing arguments. Provide both source and target paths."
        return 1
    fi

    local source_path="$1"
    local target_path="$2"

    # Check if the source path exists
    if [ ! -e "$source_path" ]; then
        print_error "Source path does not exist: $source_path"
        return 1
    fi

    # If the target path already exists
    if [ -e "$target_path" ]; then
        # If it's a symlink, remove it
        if [ -L "$target_path" ]; then
            print_message "Removing existing symlink at $target_path"
            rm "$target_path"
            if [ ! -L "$target_path" ]; then
                print_message "Successfully removed symlink at $target_path"
            else
                print_error "Failed to remove symlink at $target_path"
                return 1
            fi
        else
            # If not a symlink, back it up
            local backup_dir="$(dirname "$target_path")/backup"
            local backup_file="$backup_dir/$(basename "$target_path")_$(date +%F_%T)"
            print_message "Backing up existing file/directory at $target_path to $backup_file"
            mkdir -p "$backup_dir"
            mv "$target_path" "$backup_file"
            if [ ! -e "$target_path" ] && [ -e "$backup_file" ]; then
                print_message "Successfully backed up to $backup_file"
            else
                print_error "Failed to backup $target_path"
                return 1
            fi
        fi
    fi

    # Create the symlink
    ln -s "$source_path" "$target_path"
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        print_message "Successfully created symlink: $target_path -> $source_path"
    else
        print_error "Failed to create symlink from $target_path to $source_path"
        return 1
    fi
}

clear_broken_symlinks() {
    # This function finds and removes broken symlinks within a given directory.
    # Parameters:
    # $1: Directory to search for broken symlinks.

    # Check if the directory argument is provided
    if [ -z "$1" ]; then
        print_error "Missing directory argument."
        return 1
    fi

    local dir="$1"
    
    # Check if the given directory exists
    if [ ! -d "$dir" ]; then
        print_error "Directory does not exist: $dir"
        return 1
    fi

    # Find broken symlinks in the given directory
    find "$dir" -type l ! -exec test -e {} \; -print | while read -r symlink; do
        # Attempt to remove the broken symlink and print the status
        if rm "$symlink"; then
            print_message "Removed broken symlink at: $symlink"
        else
            print_error "Failed to remove broken symlink at: $symlink"
        fi
    done
}
