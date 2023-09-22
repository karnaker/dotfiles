#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Update and upgrade Homebrew"
brew update && brew upgrade
success "Finished updating and upgrading Homebrew."

info "Configure Xcode command-line tools to use the newly-installed version of Xcode..."
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license
success "Configure Xcode command-line tools to use the newly-installed version of Xcode."
