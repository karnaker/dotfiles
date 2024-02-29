# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# nvm (Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"  # Set nvm installation directory
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set JAVA_HOME and add Java bin directory to PATH
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Set the ANDROID_HOME environment variable to the Android SDK path
export ANDROID_HOME=$HOME/Library/Android/sdk
# Add the Android Emulator binary path to the PATH environment variable
export PATH=$PATH:$ANDROID_HOME/emulator
# Add the Android platform-tools directory to the PATH environment variable
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Source 1Password CLI integration for AWS CLI authentication
source /Users/vikram/.config/op/plugins.sh
