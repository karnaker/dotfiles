#!/usr/bin/env sh

# Import print functions
. "$(pwd)/scripts/print_functions.sh"

# Create symbolic links with error checking and backup handling
create_symlink() {
    # Parameters:
    # $1: Source file or directory
    # $2: Target file or directory

    local source="$1"
    local target="$2"

    verify_arguments "$source" "$target" || return 1
    handle_existing_target "$target" || return 1
    link_source_to_target "$source" "$target"
}

# Check if both source and target arguments are provided
verify_arguments() {
    local source="$1"
    local target="$2"

    if [ -z "$source" ] || [ -z "$target" ]; then
        print_error "Missing arguments. Provide both source and target paths."
        return 1
    elif [ ! -e "$source" ]; then
        print_error "Source path does not exist: $source"
        return 1
    fi
}

# Handle existing target by removing or backing up
handle_existing_target() {
    local target="$1"

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            remove_symlink "$target"
        else
            backup_target "$target"
        fi
    fi
}

# Remove an existing symlink
remove_symlink() {
    local target="$1"

    print_message "Removing existing symlink at $target"
    rm "$target" && print_message "Removed symlink at $target" || print_error "Failed to remove symlink at $target"
}

# Backup the existing target file or directory
backup_target() {
    local target="$1"
    local backup_dir="$(dirname "$target")/backup"
    local backup_file="$backup_dir/$(basename "$target")_$(date +%F_%T)"

    print_message "Backing up existing file/directory at $target to $backup_file"
    mkdir -p "$backup_dir" && mv "$target" "$backup_file" && print_message "Backed up to $backup_file" || print_error "Failed to backup $target"
}

# Create a symbolic link from source to target
link_source_to_target() {
    local source="$1"
    local target="$2"

    ln -s "$source" "$target" && print_message "Created symlink: $target -> $source" || print_error "Failed to create symlink from $target to $source"
}

# Clear broken symlinks in a directory, including hidden files
clear_broken_symlinks() {
    # Parameters:
    # $1: Directory to search for broken symlinks

    local dir="$1"

    # Validate the directory parameter
    if [ -z "$dir" ] || [ ! -d "$dir" ]; then
        print_error "Invalid directory: $dir"
        return 1
    fi

    # Iterate over all files, including hidden files and directories
    for entry in "$dir"/{,.[!.],..?}*; do

        # Skip non-existent glob matches
        [ ! -e "$entry" ] && [ ! -L "$entry" ] && continue

        # Handle broken symlinks and non-symlinks
        if is_broken_symlink "$entry"; then
            print_message "Broken symlink found: $entry"
            remove_broken_symlink "$entry"
        else
            print_message "Not a broken symlink: $entry"
        fi
    done
}

# Check if a file is a broken symlink
is_broken_symlink() {
    local file="$1"
    [ ! -e "$file" ] && [ -L "$file" ]
}

# Remove a broken symlink
remove_broken_symlink() {
    local symlink="$1"

    rm "$symlink" && print_message "Removed broken symlink: $symlink" || print_error "Failed to remove broken symlink: $symlink"
}
