#!/usr/bin/env zsh

# Inform the user that the bootstrap process is starting
echo -e "\n\033[1;36m==== Starting the Bootstrap Process ====\033[0m\n"

# Check if Homebrew is installed. If it's not, install it.
if [[ ! $(which brew) ]]; then
  echo -e "\033[1;36m==== Installing Homebrew ====\033[0m"
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update the Homebrew recipes to their latest versions
echo -e "\033[1;36m==== Updating Homebrew Recipes ====\033[0m"
brew update

# Upgrade all installed formulae to their latest versions
echo -e "\033[1;36m==== Upgrading Installed Formulae ====\033[0m"
brew upgrade

# Install specific packages and software (only if they aren't already installed)
echo -e "\033[1;36m==== Installing Specified Packages and Software ====\033[0m"
brew install heroku mongodb mas node redis coreutils git
brew install --cask 1password acrobat-pro acrobat-reader android-studio discord docker exodus expressvpn flutter google-chrome iterm2 ledger-live mongodb-compass ngrok paintbrush rectangle slack visual-studio-code vlc zoom

# Inform the user that the bootstrap process is complete
echo -e "\n\033[1;36m==== Bootstrap Process Complete! ====\033[0m\n"
