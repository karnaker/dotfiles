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

    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    1. Follow any next steps advised by Homebrew. For example, on Apple Silicon machines, Homebrew will provide commands to add Homebrew to your PATH: Run these two commands in your terminal to add Homebrew to your PATH
        ```zsh
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/vikram/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ```

    ```zsh
    brew install git
    ```

3. Clone this repository

    ```bash
    git clone git@github.com:karnaker/dotfiles.git
    ```
    
4. Run the `bootstrap.sh` script
    1. Alternatively, only run the `setup.sh` scripts in specific subfolders if you don't need everything
5. Restart your Mac
6. (Optional) Point your Alfred preference sync to a backed up folder
7. Login to applications, enter license keys, set preferences
    1. iTerm2: Import my JSON profile and set as default
    1. 1password
    1. Rectangle
    1. Google Chrome
    1. Google Drive
    1. Etc.

## Customisation
I strongly encourage you to play around with the configurations, and add or remove features.
If you would like to use these dotfiles for yourself, I'd recommend changing at least the following:

#### Git
* The .gitconfig file includes my [user] config, replace these with your own user name and email

#### MacOS
* At the top of the setup.sh file, my computer name is set, replace this with your own computer name

#### Packages
This folder is a collection of the programs and utilities I use frequently. These lists can easily be amended to your liking.

#### Repos
This folder is a collection of my own repos, some of which are even private. The existing lists can easily be edited or replaced by custom lists.

## Contents
### Root (/)
* bootstrap.sh - Calls all setup.sh scripts

### Git (git/)
* setup.sh - Symlinks all git files to `~/`
* .gitignore_global - Contains global gitignores
* .gitconfig - Sets several global Git variables

### Iterm2 (iterm2/)
* vk mbp.json - iTerm2 profile

### macOS Preferences (macos/)
* setup.sh - Executes a long list of commands pertaining to macOS Preferences

### Miniconda (miniconda/)
* postsetup.sh - Executes commands to set up shell for Miniconda

### Packages (packages/)
* setup.sh - Installs the contents of the .list files and the Brewfile

### Repositories (repos/)
* setup.sh - Clones the repositories in the .list files at the corresponding locations

### Helper Scripts (scripts/)
* functions.sh - Contains helper functions for symlinking files and printing progress messages

### Visual Studio Code (vscode/)
* setup.sh - Symlinks the settings.json file to `~/Library/Application Support/Code/User`
* settings.json - Contains user settings for Visual Studio Code

### Zsh (zsh/)
* setup.sh - Installs Oh My Zsh and Powerline fonts. Symlinks all zsh files to their corresponding location in `~`
* .zshrc - zsh configuration

## Known Issues

1. macos > setup.sh :
    1. Error thrown when running: `defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2`
    1. macos setup.sh script exits during first run
1. repos > setup.sh : Prints "failed to clone" even though repos are cloned successfully

## References
1. [How to Set up an Apple Mac for Software Development](https://www.stuartellis.name/articles/mac-setup/)
1. [GitHub does dotfiles](https://dotfiles.github.io/)
1. [Dotfiles: automating macOS system configuration](https://kalis.me/dotfiles-automating-macos-system-configuration/)
    1. [rkalis/dotfiles](https://github.com/rkalis/dotfiles)
1. [Wes Bos' Command Line Power User Course](https://courses.wesbos.com/account/access/6208a5fd4407c61ab3ce1368)
1. [Oh My Zsh](https://ohmyz.sh/)
    1. [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
1. [Setup macOS 2021 For Optimal Command Line Productivity](https://matt.sh/setup-2021-late)
1. [dockutil](https://github.com/kcrawford/dockutil)
    1. [Example use of dockutil in dotfiles by Grsmto](https://github.com/Grsmto/dotfiles/blob/master/macos/dock.sh)
