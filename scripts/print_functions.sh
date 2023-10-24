#!/usr/bin/env sh

# Colors for printing
CYAN="\033[1;36m"      # Regular messages
RED="\033[1;31m"       # Errors
YELLOW="\033[1;33m"    # Warnings/Notices
RESET="\033[0m"

# Function to print formatted messages
# Usage: print_message "Your message here"
print_message() {
    local message="$1"
    printf "${CYAN}==== $message ====${RESET}\n"
}

# Function to print error messages
# Usage: print_error "Your error message here"
print_error() {
    local error_message="$1"
    printf "${RED}Error: $error_message${RESET}\n"
}

# Function to print warning messages
# Usage: print_warning "Your warning message here"
print_warning() {
    local warning_message="$1"
    printf "${YELLOW}Warning: $warning_message${RESET}\n"
}
