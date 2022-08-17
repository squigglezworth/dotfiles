#!/bin/bash
set -e

if [ ! -f /usr/lib/x86_64-linux-gnu/rofi/blezz.so ]; then
    sudo apt-get -qq install rofi
    sudo apt-get -qq build-dep rofi
    git clone -q https://github.com/davatorium/rofi-blezz /tmp/rofi-blezz
    cd /tmp/rofi-blezz
    autoreconf --install
    ./configure
    sudo make install
    sudo rm -rf /tmp/rofi-blezz
else
    echo "rofi-blezz already installed, skipping!"
fi
