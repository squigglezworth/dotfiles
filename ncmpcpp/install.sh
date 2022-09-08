#!/bin/bash
set -e

if [ ! ncmpcpp ]; then
    sudo apt-get -qq build-dep ncmpcpp
    git clone -q https://github.com/squigglezworth/ncmpcpp/ /tmp/ncmpcpp
    cd /tmp/ncmpcpp/
    ./autogen.sh
    ./configure
    make -j4
    sudo make install
    sudo rm -rf /tmp/ncmpcpp
else
    echo "ncmpcpp already installed, skipping!"
fi
