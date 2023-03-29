#!/bin/bash
set -e

if [ ! -d /opt/firefox/ ]; then
    wget --quiet "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-CA" -O /tmp/firefox.tar.bz2
    sudo tar xvjf /tmp/firefox.tar.bz2 --directory /opt/
    sudo ln -sf /opt/firefox/firefox /usr/local/bin/firefox
    sudo chmod +x /usr/local/bin/firefox
    sudo rm -rf /tmp/firefox.tar.bz2
else
    echo "Firefox already installed, skipping!"
fi
