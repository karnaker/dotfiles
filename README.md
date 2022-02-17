# Dotfiles

Based on [Rosco Kalis' dotfiles](https://github.com/rkalis/dotfiles/), but customized for my preferences. See:
* [Dotfiles: automating macOS system configuration](https://kalis.me/dotfiles-automating-macos-system-configuration/)

## Usage

### If it's the first time setting up your Mac

1. Language: English
1. Select Your Country or Region: United States
1. Accessibility
   1. Vision
      1. Appearance: Dark
1. Select Your Wi-Fi Network
1. Sign In With Your Apple ID
1. Account Name: vikram
1. Analytics: Do not share any information
1. Improve Siri & Dictation: Not Now
1. FileVault Disk Encryption: Turn on FileVault disk encryption
1. iCloud Keychain: Set up later
1. Apple Pay: Set up later

### Update software

1. Run Software Update, and ensure that the operating system is at the latest point release.

### Run dotfile scrips

1. Generate new SSH keys and add them to your GitHub account
    1. See: [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
    1. Alternatively, restore your safely backed up SSH keys to `~/.ssh/`
2. Install Homebrew and git
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install git
  ```
3. Clone this repository
  ```bash
  git clone git@github.com:karnaker/dotfiles.git
  ```
4. Run the `bootstrap.sh` script
    1. Alternatively, only run the `setup.sh` scripts in specific subfolders if you don't need everything
5. (Optional) Point your Alfred preference sync to a backed up folder
6. Login to applications, enter license keys, set preferences

## Customisation
I strongly encourage you to play around with the configurations, and add or remove features.
If you would like to use these dotfiles for yourself, I'd recommend changing at least the following:

#### Git
* The .gitconfig file includes my [user] config, replace these with your own user name and email

#### OSX
* At the top of the setup.sh file, my computer name is set, replace this with your own computer name

#### Packages
This folder is a collection of the programs and utilities I use frequently. These lists can easily be amended to your liking.

#### Repos
This folder is a collection of my own repos, some of which are even private. The existing lists can easily be edited or replaced by custom lists.

## Contents
### Root (/)
* bootstrap.sh - Calls all setup.sh scripts

### Zsh (zsh/)
* setup.sh - Symlinks all zsh files to their corresponding location in `~`
* .zshrc - zsh configuration
* vk mbp.json - iTerm2 profile

### Git (git/)
* setup.sh - Symlinks all git files to `~/`
* .gitignore_global - Contains global gitignores
* .gitconfig - Sets several global Git variables

### macOS Preferences (macos/)
* setup.sh - Executes a long list of commands pertaining to macOS Preferences

### Packages (packages/)
* setup.sh - Installs the contents of the .list files and the Brewfile

### Repositories (repos/)
* setup.sh - Clones the repositories in the .list files at the corresponding locations

### Helper Scripts (scripts/)
* functions.sh - Contains helper functions for symlinking files and printing progress messages

### Visual Studio Code (vscode/)
* setup.sh - Symlinks the settings.json file to `~/Library/Application Support/Code/User`
* settings.json - Contains user settings for Visual Studio Code