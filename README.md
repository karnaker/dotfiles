# Dotfiles

This repository contains a collection of configuration files and scripts to set up a new macOS environment. It includes configurations for various tools, packages, and system settings, ensuring a consistent and automated setup experience.

## Directory Structure

```plaintext
dotfiles/
│
├── bootstrap.sh           # The main bootstrap file
│
├── configs/               # Directory for configuration files
│   ├── git/
│   │   ├── .gitconfig
│   │   ├── .gitignore_global
│   ├── iterm2/
│   │   ├── iterm2_profile_base.json
│   │   ├── themes/
│   ├── repos/             # Directory containing lists of repositories to clone
│   │   ├── agapichq.txt
│   │   ├── karnaker.txt
│   ├── vscode/
│   │   ├── settings.json
│   │   ├── extensions.txt
│   ├── zsh/
│   │   ├── .zshrc
│   ├── ...
│
├── scripts/               # Directory for various scripts
│   ├── install_packages.sh
│   ├── ...                # Other scripts can go here
│
└── README.md              # Documentation for this repository
```

## Scripts

### `bootstrap.sh`

The main script that orchestrates the entire setup process. It ensures permissions are granted, runs system tool installations, package installations, Xcode configurations, Git configurations, iTerm2 configurations, macOS configuration, Zsh configuration, VS Code configuration, and also clones repositories from provided lists.

### `scripts/clone_repositories.sh`

Handles the process of cloning repositories. It uses two lists of repositories: one for personal repositories (`configs/repos/karnaker.txt`) and one for work repositories (`configs/repos/agapichq.txt`).

### `scripts/configure_xcode.sh`

Configures Xcode after its installation via the App Store. It sets the default command-line tools and accepts the license agreement.

### `scripts/install_packages.sh`

Manages the installation of various software packages using Homebrew. It uses the `scripts/Brewfile` to determine which packages to install.

### `scripts/macos_config.sh`

Configures macOS settings and preferences to ensure a customized and consistent environment. The script covers a wide range of settings, including computer name, UI/UX preferences, system defaults, and more.

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

## Configurations

Configuration files are stored in the `configs/` directory. These files are used to set up various tools and applications, ensuring they operate with preferred settings.

### Git Configurations (`configs/git/`)

- `.gitconfig`: Contains global configurations for Git. It specifies user details, aliases, core settings, diff and merge tool settings, and more. This file is meant to be symlinked to the user's home directory.

- `.gitignore_global`: A global `.gitignore` file that specifies patterns for files and directories that should be ignored across all Git repositories. This is especially useful for ignoring system-specific files, such as `.DS_Store` on macOS. This file is meant to be symlinked to the user's home directory.

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

- `.zshrc`: The configuration file for Zsh. It specifies the path to the Oh My Zsh installation, sets the theme, determines auto-update behavior, and lists the desired plugins. This file should be symlinked to the user's home directory.

## Usage

To set up a new macOS environment using these dotfiles:

1. Clone this repository to your local machine.
2. Navigate to the directory: `cd path/to/dotfiles`
3. Ensure the script has execute permissions: `chmod +x bootstrap.sh`
4. Run the bootstrap script: `./bootstrap.sh`

## Important Notes

- The bootstrap process will prompt for the sudo password to ensure necessary permissions.
- Make sure to review the scripts and configurations before running them, especially if you're using this on a system with existing configurations.
- The setup process is designed to be idempotent. Running it multiple times should not produce different results.

## Contributing

If you wish to contribute to these dotfiles, please fork the repository and submit a pull request.

## License

[MIT License](license)
