#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Installing Oh My Zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

success "Successfully installed Oh My Zsh."

info "Installing Powerline fonts"

substep_info "clone"
git clone https://github.com/powerline/fonts.git --depth=1
substep_info "install"
cd fonts
./install.sh
substep_info "clean-up a bit"
cd ..
rm -rf fonts

success "Successfully installed Powerline fonts."

info "Setting up zsh shell..."

find . -name ".zshrc" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Successfully set up zsh shell."
