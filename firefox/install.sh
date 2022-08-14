#!/bin/bash
set -e

if [ ! -d /opt/firefox/ ]; then
    wget --quiet "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-CA" -O /tmp/firefox.tar.bz2
    sudo mkdir -p /opt/firefox
    sudo tar xvjf /tmp/firefox.tar.bz2 --directory /opt/firefox
    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
    sudo rm -rf /tmp/firefox.tar.bz2
else
    echo "Firefox already installed, skipping!"
fi
