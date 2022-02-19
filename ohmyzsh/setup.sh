#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

info "Install Oh My Zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

success "Successfully installed Oh My Zsh."

info "Install Powerline fonts"

substep_info "clone"
git clone https://github.com/powerline/fonts.git --depth=1
substep_info "install"
cd fonts
./install.sh
substep_info "clean-up a bit"
cd ..
rm -rf fonts

success "Successfully installed Powerline fonts."
