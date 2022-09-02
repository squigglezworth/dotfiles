#!/bin/bash

if [ ! steam ]; then
    echo steam steam/question select "I AGREE" | sudo debconf-set-selections
    echo steam steam/license note '' | sudo debconf-set-selections
    sudo dpkg --add-architecture i386
    sudo apt-get -qq update
    sudo apt-get -qq install steam mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
else
    echo "Steam already installed, skipping!"
fi
