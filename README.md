# Dotfiles

This repository contains a collection of configuration files and scripts to set up a new macOS environment. It includes configurations for various tools, packages, and system settings, ensuring a consistent and automated setup experience.

## Dependencies

- Active internet connection
- macOS version (Sonoma 14.2.1)

## Usage

### If it's the first time setting up your Mac

Follow the instructions below for a smooth initial setup of macOS:

1. **Language:** English
2. **Select Your Country or Region:** United States
3. **Accessibility:** 
   1. **Vision**
      1. **Appearance:** Dark
4. **Select Your Wi-Fi Network**
5. **Sign In With Your Apple ID**
6. **Account Name:** vikram (Replace with your desired account name)
7. **Analytics:** Do not share any information
8. **Improve Siri & Dictation:** Not Now
9. **FileVault Disk Encryption:** Turn on FileVault disk encryption
10. **iCloud Keychain:** Set up later
11. **Apple Pay:** Set up later

### Start with an up-to-date system:

1. Click on the Apple logo in the top-left corner of the screen.
2. Select "System Settings."
3. Navigate to "Software Update."
4. If updates are available, click "Upgrade Now" to install them. This may require a restart.

### SSH Key Setup:

Before you start cloning repositories or pushing changes to GitHub, you'll need to set up SSH keys:

1. [Check for existing SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)
2. [Generate a new SSH key and add it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. [Add your SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
4. [Test your SSH connection](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
5. Alternatively, restore your safely backed-up SSH keys

### Installing Essential Tools: Homebrew and Git

Before we proceed with the main setup, it's essential to install some foundational tools that our scripts and configurations rely on. Homebrew is a package manager for macOS that makes it easy to install software, and Git is a distributed version control system.

1. **Install Homebrew**:

    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    - **Note**: After running the above command, Homebrew might provide additional instructions, especially if you're on an Apple Silicon machine. Make sure to follow any steps advised by Homebrew.

    For Apple Silicon machines, you may need to add Homebrew to your PATH:

    ```zsh
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```

2. **Install Git**:

    ```zsh
    brew install git
    ```

    - **Note**: Installing Git via Homebrew ensures you have the latest version, and it's easy to update in the future.

### Setting up your development environment

1. **Prepare the dotfiles directory**:
   Ensure that the target directory exists. If it doesn't, create it. 
   
   ```zsh
   # Create the directory structure if it doesn't exist
   mkdir -p ~/repos/github/karnaker
   ```

2. **Clone the dotfiles repository**:
   Clone this repository to the desired location on your local machine.

   ```zsh
   # Navigate to the parent directory
   cd ~/repos/github/karnaker

   # Clone the repository via SSH
   git clone git@github.com:karnaker/dotfiles.git
   ```

3. **Navigate to the directory**:
   
   ```zsh
   cd dotfiles
   ```

4. **Ensure script permissions**:
   Make sure the bootstrap script is executable.

   ```zsh
   # Give the script execute permissions
   chmod +x bootstrap.sh
   ```

5. **Run the bootstrap script**:

   ```zsh
   ./bootstrap.sh
   ```

### Post-Installation Steps

After running the bootstrap script and setting up the essential tools and configurations, there are some post-installation steps that require manual intervention:

1. **Restart Your Mac**:

    ```zsh
    sudo shutdown -r now
    ```

2. **Login to Applications, Enter License Keys, and Set Preferences**:

   Here are some common applications you might want to configure:

   - **iTerm2**: Import your JSON profile and set it as default. To do this:
     1. Open iTerm2.
     2. Navigate to iTerm -> Settings or press `Cmd + ,`.
     3. Under the `Profiles` tab, click on the `Other Actions` dropdown.
     4. Select `Import JSON Profiles` and choose your profile (typically found in `configs/iterm2/iterm2_profile_base.json`).
     5. Set the imported profile as the default.

   - **Rectangle**: Launch the app and configure your preferred window snapping shortcuts.
     
   - **1Password**: Open the application, log in with your credentials, and set up any necessary integrations or browser extensions.
     
   - **Google Chrome**: Sign in to sync your bookmarks, extensions, and other settings. Remember to install essential extensions and configure them as per your requirements.

   - **Google Drive**: Log in and set up sync preferences.
     
   - **Etc.**: Any other apps you use regularly should be set up at this point. This could include communication tools like Slack, development tools like Postman, or design tools like Figma. Remember to log in, provide any necessary license keys, and configure them as per your needs.

**Note**: These post-installation steps are a general guide and might vary based on personal preferences and specific software versions. It's crucial to refer to the official documentation or support channels of individual apps for detailed setup instructions.

## Directory Structure

```plaintext
dotfiles/
│
├── bootstrap.sh                # The main bootstrap file
│
├── configs/                    # Directory for configuration files
│   ├── git/
│   │   ├── .gitconfig
│   │   ├── .gitignore_global
│   ├── homebrew/
│   │   ├── Brewfile
│   │   ├── Brewfile.lock.json  # Lock file generated by Homebrew
│   ├── iterm2/
│   │   ├── iterm2_profile_base.json
│   │   ├── themes/
│   ├── repos/                  # Directory containing lists of repositories to clone
│   │   ├── agapichq.txt
│   │   ├── karnaker.txt
│   ├── vscode/
│   │   ├── settings.json
│   │   ├── extensions.txt
│   ├── zsh/
│   │   ├── .zshrc
│   ├── ...
│
├── scripts/                    # Directory for various scripts
│   ├── install_homebrew_packages.sh
│   ├── ...                     # Other scripts can go here
│
└── README.md                   # Documentation for this repository
```

## Scripts

### `bootstrap.sh`

The main script that orchestrates the entire setup process. It ensures permissions are granted, runs system tool installations, package installations, Xcode configurations, Git configurations, iTerm2 configurations, macOS configuration, Zsh configuration, VS Code configuration, and also clones repositories from provided lists.

### `scripts/clone_repositories.sh`

Handles the process of cloning repositories. It uses two lists of repositories: one for personal repositories (`configs/repos/karnaker.txt`) and one for work repositories (`configs/repos/agapichq.txt`).

### `scripts/configure_xcode.sh`

Configures Xcode after its installation via the App Store. It sets the default command-line tools and accepts the license agreement.

### `scripts/install_homebrew_packages.sh`

Manages the installation of various software packages using Homebrew. It uses the `configs/homebrew/Brewfile` to determine which packages to install. The `Brewfile.lock.json` is generated after a successful `brew bundle` execution to capture the current environment. It aids in debugging if subsequent `brew bundle` runs fail by comparing with previous states.

### `scripts/install_nvm_and_node.sh`

This script handles the installation and setup of `nvm` (Node Version Manager) and the latest LTS version of Node.js.

### `scripts/macos_config.sh`

Configures macOS settings and preferences to ensure a customized and consistent environment. The script covers a wide range of settings, including computer name, UI/UX preferences, system defaults, and more.

### `scripts/print_functions.sh`

A utility script that provides functions to print messages, errors, and warnings in a formatted manner. Each function makes use of terminal colors to differentiate message types.

### `scripts/setup_git_configs.sh`

Sets up Git configurations, including aliases and user information, and symlinks Git-related files.

### `scripts/setup_iterm2_configs.sh`

Downloads and updates iTerm2 themes, symlinks iTerm2 profile, and manages iTerm2 configurations.

### `scripts/setup_vscode_configs.sh`

Handles the configuration of VS Code. This includes symlinking the `settings.json` for VS Code preferences and installing extensions listed in `extensions.txt`.

### `scripts/setup_zsh_configs.sh`

Configures Zsh, installs Oh My Zsh, and symlinks the `.zshrc` file.

### `scripts/symlink_functions.sh`

This script provides utility functions for handling symbolic links.

### `scripts/system_tools.sh`

Handles the installation of essential system tools like XCode Command Line Tools and Rosetta (for M1 Macs).

### `scripts/verify_1password_cli_config.sh`

Ensures the 1Password CLI integration is correctly set up by verifying the `plugins.sh` file's presence.

## Configurations

Configuration files are stored in the `configs/` directory. These files are used to set up various tools and applications, ensuring they operate with preferred settings.

### Git Configurations (`configs/git/`)

- `.gitconfig`: Contains global configurations for Git. It specifies user details, aliases, core settings, diff and merge tool settings, and more. This file is meant to be symlinked to the user's home directory.

- `.gitignore_global`: A global `.gitignore` file that specifies patterns for files and directories that should be ignored across all Git repositories. This is especially useful for ignoring system-specific files, such as `.DS_Store` on macOS. This file is meant to be symlinked to the user's home directory.

### Homebrew Configurations (`configs/homebrew/`)

- `Brewfile`: A list of software packages and applications for Homebrew to install.

- `Brewfile.lock.json`: The `Brewfile.lock.json` is a lock file created by Homebrew to ensure uniform package installations. It's generated after a successful `brew bundle` run, capturing the environment at that point.

### iTerm2 Configurations (`configs/iterm2/`)

- `iterm2_profile_base.json`: Contains the base profile settings for iTerm2. It defines settings like text colors, working directory, blinking cursor settings, etc. This profile can be imported into iTerm2.

- `themes/`: This directory can contain iTerm2 color themes. Themes can be imported into iTerm2 to change the appearance of the terminal.

### Repositories Configurations (`configs/repos/`)

- `agapichq.txt`: Contains a list of work repositories to be cloned.

- `karnaker.txt`: Contains a list of personal repositories to be cloned.
  
### VS Code Configurations (`configs/vscode/`)

- `settings.json`: Contains various settings for the VS Code editor. These include preferences related to appearance, plugins, and other behaviors.
  
- `extensions.txt`: A list of VS Code extensions to be installed. Each line represents the identifier of an extension available on the VS Code marketplace.

### Zsh Configurations (`configs/zsh/`)

- `.zshrc`: The main configuration file for Zsh. It specifies the path to the Oh My Zsh installation, sets the theme, determines auto-update behavior, and lists the desired plugins. This file should be symlinked to the user's home directory.

## Important Notes

- The bootstrap process will prompt for the sudo password to ensure necessary permissions.
- Make sure to review the scripts and configurations before running them, especially if you're using this on a system with existing configurations.
- The setup process is designed to be idempotent. Running it multiple times should not produce different results.

## Contributing

Contributions are always welcome! If you'd like to contribute:

1. Fork the repository.
2. Create a new branch for your changes.
3. Make the desired changes in your branch.
4. Submit a pull request for review.

## License

These dotfiles are licensed under the MIT License. For more details, please see the [MIT License](license) file.
