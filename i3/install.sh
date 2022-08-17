#!/bin/bash
if ! i3 -C -c $HOME/dotfiles/i3/config; then
    sudo apt-get -qq install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev

    git clone -q https://github.com/Airblader/i3 /tmp/i3-gaps
    cd /tmp/i3-gaps
    mkdir build; cd build;
    meson --prefix /usr/local
    ninja
    sudo ninja install
    sudo rm -rf /tmp/i3-gaps
else
    echo "i3-gaps already installed, skipping!"
fi
