#!/bin/bash

list="
git
vim-gtk
tmux

dolphin
ffmpegthumbs
mplayerthumbs
kffmpegthumbnailer
okular
kolourpaint4
gimp

g++

xclip
trash-cli
xbindkeys
"

for i in $list
do
  sudo apt-get install $i -y
  if [[ $? > 0 ]]
  then
    echo "Installation of package $i failed"
    exit
  else
    echo "Package $i installed"
    echo ""
  fi
done
