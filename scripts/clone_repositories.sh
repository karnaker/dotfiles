#!/usr/bin/env sh

# Repository Cloning Script

# Colors for printing
CYAN="\033[1;36m"
RESET="\033[0m"

# Global Variables
BASE_DIR="$HOME/repos/github"
SCRIPT_DIR="$(pwd)"
PERSONAL_REPOS_FILE="$SCRIPT_DIR/configs/repos/karnaker.txt"
WORK_REPOS_FILE="$SCRIPT_DIR/configs/repos/agapichq.txt"

# Clone the repository to the specified directory structure
# $1: Repository URL
clone_repo() {
    local repo_url="$1"
    
    # Check if the repo URL ends with .git
    if [[ "$repo_url" != *.git ]]; then
        printf "${CYAN}Error: Repository URL '$repo_url' doesn't end with '.git'. Skipping...${RESET}\n"
        return
    fi

    # Extract username and repository name from the URL
    local username=$(echo "$repo_url" | cut -d':' -f 2 | cut -d'/' -f 1)
    local repo_name=$(echo "$repo_url" | cut -d'/' -f 2 | rev | cut -c 5- | rev)
    
    # Define the destination directory for the clone
    local dest_dir="$BASE_DIR/$username/$repo_name"
    
    # Check if the repository already exists
    if [ -d "$dest_dir" ]; then
        printf "${CYAN}Repository already exists: $dest_dir${RESET}\n"
        return
    fi

    # Clone the repository
    git clone "$repo_url" "$dest_dir"
    if [ $? -ne 0 ]; then
        printf "${CYAN}Failed to clone repository: $repo_url${RESET}\n"
        return
    fi
}

# Read repositories from a file and clone them
# $1: File containing a list of repositories
clone_repos_from_file() {
    local file="$1"
    
    while IFS= read -r repo_url || [ -n "$repo_url" ]; do
        if [ -n "$repo_url" ]; then
            clone_repo "$repo_url"
        fi
    done < "$file"
}

# Execution
clone_repos_from_file "$PERSONAL_REPOS_FILE"
clone_repos_from_file "$WORK_REPOS_FILE"
