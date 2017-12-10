#!/bin/bash

# Preconditions for succesful configuration
if [ ! -d "~/apps/firefox" ]; then
  echo "Error: firefox folder does not exist"
  exit 1
fi

# Cd to home
cd ~/

# Firefox setup
# desktop configuration files involves type recognition, context menu
#  execution, program classification, etc
# update-alternatives is used to manage the alternatives' system in
#  debian based distros, which pretty is a symlink management of
#  singular links to a group of similar programs (or different
#  versions of the same program). It's how 'default' applications
#  work (args: alt_link(generic path), alt_name(sym name in alt dir),
#  path(specific path), priority(lower=more privilage)
sudo apt-get remove firefox
sudo ln -s ~/apps/firefox/firefox /usr/local/bin # firefox visible from PATH
sudo cp ~/.init_pack/desktop/firefox.desktop /usr/share/applications/ # desktop configuration file
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/local/bin/firefox 100