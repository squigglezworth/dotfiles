#!/bin/bash
set -e

sudo apt-get -qq install rofi
sudo apt-get -qq build-dep rofi
git clone -q https://github.com/davatorium/rofi-blezz /tmp/rofi-blezz
cd /tmp/rofi-blezz
autoreconf --install
./configure
sudo make install
sudo rm -rf /tmp/rofi-blezz
