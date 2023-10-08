#!/usr/bin/env zsh

# Use formatting to make the beginning of the process stand out
echo -e "\n\033[1;36m==== Preparing to Run Bootstrap ====\033[0m\n"

# Grant execute permissions to bootstrap.zsh
echo -e "\033[1;36m==== Granting Execute Permissions to bootstrap.zsh ====\033[0m"
chmod +x bootstrap.zsh

# Run bootstrap.zsh
echo -e "\033[1;36m==== Running bootstrap.zsh ====\033[0m"
./bootstrap.zsh

# Use formatting to indicate the end of the process
echo -e "\n\033[1;36m==== Process Complete! ====\033[0m\n"
