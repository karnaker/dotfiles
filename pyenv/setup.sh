#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Installing latest python version to run..."
pyenv install 3.10.2
pyenv global 3.10.2
success "Finished installing latest python version."
