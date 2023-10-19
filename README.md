# Dotfiles

This repository contains a collection of configuration files and scripts to set up a new macOS environment. It includes configurations for various tools, packages, and system settings, ensuring a consistent and automated setup experience.

## Directory Structure

```plaintext
dotfiles/
│
├── bootstrap.sh           # The main bootstrap file
│
├── scripts/               # Directory for various scripts
│   ├── install_packages.sh
│   ├── ...                # Other scripts can go here
│
├── configs/               # Directory for configuration files
│   ├── git/
│   │   ├── .gitconfig
│   │   ├── ...            # Other Git-related configuration files
│   ├── zsh/
│   │   ├── .zshrc
│   ├── ...
│
└── README.md              # Documentation for this repository
```

## Scripts

### `bootstrap.sh`

The main script that orchestrates the entire setup process. It ensures permissions are granted, runs system tool installations, package installations, Xcode configurations, Git configurations, iTerm2 configurations, macOS configuration, and Zsh configuration.

### `scripts/system_tools.sh`

Handles the installation of essential system tools like XCode Command Line Tools and Rosetta (for M1 Macs).

### `scripts/install_packages.sh`

Manages the installation of various software packages using Homebrew. It uses the `scripts/Brewfile` to determine which packages to install.

### `scripts/configure_xcode.sh`

Configures Xcode after its installation via the App Store. It sets the default command-line tools and accepts the license agreement.

### `scripts/setup_git_configs.sh`

Sets up Git configurations, including aliases and user information, and symlinks Git-related files.

### `scripts/setup_iterm2_configs.sh`

Downloads and updates iTerm2 themes, symlinks iTerm2 profile, and manages iTerm2 configurations.

### `scripts/macos_config.sh`

Configures macOS settings and preferences to ensure a customized and consistent environment. The script covers a wide range of settings, including computer name, UI/UX preferences, system defaults, and more.

### `scripts/setup_zsh_configs.sh`

Configures Zsh, installs Oh My Zsh, and symlinks the `.zshrc` file.

## Configurations

Configuration files are stored in the `configs/` directory. These files are used to set up various tools and applications, ensuring they operate with preferred settings.

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
