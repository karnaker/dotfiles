#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Setup shell for Miniconda..."

conda init "$(basename "${SHELL}")"

success "Finished setting up shell for Miniconda."
