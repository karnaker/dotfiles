#!/usr/bin/env sh

# Import print functions
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

# Function to check the exit status of a command and handle errors
check_exit_status() {
    # Parameters:
    # $1: Exit status of the previously executed command
    # $2: Success message
    # $3: Error message

    local exit_status="$1"
    local success_message="$2"
    local error_message="$3"

    # If the command was successful
    if [ "$exit_status" -eq 0 ]; then
        print_message "$success_message"
    else
        print_error "$error_message"
        return 1
    fi
}

# Function to remove a broken symlink
remove_broken_symlink() {
    # Parameters:
    # $1: Path to the broken symlink

    local symlink_path="$1"
    rm "$symlink_path"

    # Check if the removal was successful and print the status
    check_exit_status $? "Removed broken symlink at: $symlink_path" "Failed to remove broken symlink at: $symlink_path"
}

# Function to check if a symlink is broken
is_broken_symlink() {
    # Parameters:
    # $1: Path to the symlink

    local symlink_path="$1"

    # Test if the symlink is broken
    [ ! -e "$symlink_path" ] && [ -L "$symlink_path" ]
}

# Function to clear broken symlinks from a given directory (not recursive)
clear_broken_symlinks() {
    # Parameters:
    # $1: Parent directory to search for broken symlinks

    local parent_dir="$1"

    # Check if the directory argument is provided
    if [ -z "$parent_dir" ]; then
        print_error "Missing directory argument."
        return 1
    fi

    # Check if the given directory exists
    if [ ! -d "$parent_dir" ]; then
        print_error "Directory does not exist: $parent_dir"
        return 1
    fi

    # List all files and directories in the given directory
    for entry in "$parent_dir"/*; do
        # If the entry is a broken symlink
        if is_broken_symlink "$entry"; then
            # Attempt to remove the broken symlink
            remove_broken_symlink "$entry"
        fi
    done
}
