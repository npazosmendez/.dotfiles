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
libreoffice

g++
nasm
openjdk-8-jdk
texlive-full
gdb

build-essential
libx11-dev
libgtk2.0-dev
libreadline-dev

imagemagick
xclip
trash-cli
xbindkeys
unrar
tree
htop
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
