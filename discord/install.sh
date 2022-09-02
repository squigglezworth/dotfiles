#!/bin/bash
set -e

if [ ! discord ]; then
    wget --quiet "https://discord.com/api/download?platform=linux&format=deb" -O /tmp/discord.deb
    dpkg-deb -x /tmp/discord.deb /tmp/discord-tmp
    dpkg-deb --control /tmp/discord.deb /tmp/discord-tmp/DEBIAN
    sed -i 's/libappindicator3-1/libayatana-appindicator3-1/' /tmp/discord-tmp/DEBIAN/control
    dpkg -b /tmp/discord-tmp /tmp/discord-fixed.deb
    sudo apt-get -qq install /tmp/discord-fixed.deb
    sudo rm -rf /tmp/discord-tmp /tmp/discord.deb /tmp/discord-fixed.deb
else
    echo "Discord already installed, skipping!"
fi
