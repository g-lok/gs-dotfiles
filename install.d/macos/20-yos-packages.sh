#!/usr/bin/env bash
# Ignore if we're not on OSX
[[ "$OSTYPE" =~ darwin* ]] || exit 0

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
 while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# make sure we have xcode...homebrew requires
if test ! $(which brew); then
   echo "Installing homebrew..."
   sudo -u $dotfiles_usr /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Ask for the administrator password upfront.
# sudo -v

sudo -u $dotfiles_usr brew doctor

# Upgrade any already-installed formulae.
sudo -u $dotfiles_usr brew upgrade

# Make sure we’re using the latest Homebrew.
sudo -u $dotfiles_usr brew update

# Install packages in local Brewfile
sudo -u $dotfiles_usr brew bundle install --file $dotfiles_wd/install.d/Brewfile --verbose
sudo -u $dotfiles_usr brew bundle check --file $dotfiles_wd/install.d/Brewfile
sudo -u $dotfiles_usr brew bundle cleanup --file $dotfiles_wd/install.d/Brewfile

# Remove outdated versions from the cellar.
sudo -u $dotfiles_usr brew cleanup


LOCALBASH="/usr/local/bin/bash"
if ! grep -q $LOCALBASH /etc/shells; then
  echo $LOCALBASH | sudo tee -a /etc/shells
  sudo chsh -s $LOCALBASH $USER
fi

# Move /usr/local/bin to the top of the path
sudo sed -ie  '/^\/usr\/local\/bin/!H;//p;$!d;g;s/\n//' /etc/paths

