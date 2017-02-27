#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/vim" ~/.vim

# Package managers & packages

#install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install python
brew install python3
brew install hub

#install brew-cask

# Install Caskroom

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install packages

apps=(
google-chrome
slack
spotify
virtualbox
)

brew cask install "${apps[@]}"

# Quick Look Plugins
# (https://github.com/sindresorhus/quick-look-plugins)

source osxdefaults.sh


# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
    . "$EXTRA_DIR/install.sh"
fi
