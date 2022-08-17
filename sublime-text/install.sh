#!/bin/bash
set -e

if ! which subl; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg &>/dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list &>/dev/null

    sudo apt-get -qq update
    sudo apt-get -qq install sublime-text
else
    echo "Sublime Text already installed, skipping!"
fi
