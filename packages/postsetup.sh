#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Update and upgrade Homebrew"
brew update && brew upgrade
success "Finished updating and upgrading Homebrew."

info "Installing Ruby gems..."

gem install jekyll
gem install bundler

success "Finished installing Ruby gems."
