#!/bin/bash

# Cd to home
cd ~/

# 'Clone' dotfiles on home directory
git init .
git remote add -t \* -f origin https://github.com/eyesmd/dotfiles.git # -f forces a fetch after adding the remote repo, -t idk 
git checkout master

# Tmux setup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux start-server   # start a server but don't attach to it
tmux new-session -d   # create a new session but don't attach to it either
~/.tmux/plugins/tpm/scripts/install_plugins.sh   # install the plugins
tmux kill-server   # killing the server is not required, I guess

# Vim setup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
