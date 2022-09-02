#!/bin/bash
set -e

if [ ! picom ]; then
    git clone -q https://github.com/yshui/picom /tmp/picom
    cd /tmp/picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
else
    echo "picom already installed, skipping!"
fi
