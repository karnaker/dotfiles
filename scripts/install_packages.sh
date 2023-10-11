#!/usr/bin/env sh

# Inform the user that the bootstrap process is starting
echo -e "\n\033[1;36m==== Starting the Bootstrap Process ====\033[0m\n"

# Check if Homebrew is installed. If it's not, install it.
if [ ! $(which brew) ]; then
  echo -e "\033[1;36m==== Installing Homebrew ====\033[0m"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update the Homebrew recipes to their latest versions
echo -e "\033[1;36m==== Updating Homebrew Recipes ====\033[0m"
brew update

# Upgrade all installed formulae to their latest versions
echo -e "\033[1;36m==== Upgrading Installed Formulae ====\033[0m"
brew upgrade

# Install specific packages and software (only if they aren't already installed)

# Tap necessary repositories for specific formulae
echo -e "\033[1;36m==== Tapping Necessary Repositories ====\033[0m"
brew tap heroku/brew
brew tap mongodb/brew

# Install cask software
echo -e "\033[1;36m==== Installing Cask Software ====\033[0m"
brew install --cask 1password adobe-acrobat-pro adobe-acrobat-reader android-studio discord docker exodus expressvpn flutter google-chrome google-drive iterm2 krita ledger-live mongodb-compass ngrok paintbrush rectangle slack visual-studio-code vlc zoom

# Install formulae
echo -e "\033[1;36m==== Installing Formulae ====\033[0m"
brew install cocoapods coreutils git heroku mas mongodb-community node redis

# Install software from the Mac App Store using mas
echo -e "\033[1;36m==== Installing Mac App Store Software ====\033[0m"
mas install 682658836 # GarageBand
mas install 408981434 # iMovie
mas install 497799835 # Xcode

# Inform the user that the bootstrap process is complete
echo -e "\n\033[1;36m==== Bootstrap Process Complete! ====\033[0m\n"
