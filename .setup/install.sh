#!/bin/bash
set -e
## ███████ ██    ██ ███████ ████████ ███████ ███    ███ 
## ██       ██  ██  ██         ██    ██      ████  ████ 
## ███████   ████   ███████    ██    █████   ██ ████ ██ 
##      ██    ██         ██    ██    ██      ██  ██  ██ 
## ███████    ██    ███████    ██    ███████ ██      ██ 

echo -ne "\t Installing system tools... "
sudo apt-get -qq install apt-transport-https atop default-jre dnsutils htop iotop lshw net-tools nethogs procps software-properties-common tmux vim  &>>/tmp/dotfiles.log
echoDone
echo -ne "\t Enabling non-free/contrib repos... "
sudo apt-add-repository non-free &>>/tmp/dotfiles.log
sudo apt-add-repository contrib &>>/tmp/dotfiles.log
echoDone
if lspci | grep NVIDIA &>/dev/null; then
    echo -ne "\t Installing GPU drivers... "
    sudo apt-get -qq update &>>/tmp/dotfiles.log
    sudo apt-get -qq install nvidia-driver firmware-misc-nonfree &>>/tmp/dotfiles.log
    echoDone
else
    echo -e "\t No nVidia GPU detected, skipping driver installation!"
fi

##  ██████  ███████ ███████ ██   ██ ████████  ██████  ██████  
##  ██   ██ ██      ██      ██  ██     ██    ██    ██ ██   ██ 
##  ██   ██ █████   ███████ █████      ██    ██    ██ ██████  
##  ██   ██ ██           ██ ██  ██     ██    ██    ██ ██      
##  ██████  ███████ ███████ ██   ██    ██     ██████  ██      

echo -e "\t Installing desktop environment:"
LIST="arandr dunst feh lxappearance nemo pass pulseeffects pulsemixer qt5ct rofi xinit"
echo -ne "\t\t Installing basic utils ($(colorList $LIST)) ... "
sudo apt-get -qq install $LIST &>>/tmp/dotfiles.log; echoDone
echo -ne "\t\t Installing $(randColor i3-gaps) ... "
$PWD/i3/install.sh &>>/tmp/dotfiles.log; echoDone
# echo -e "\t\t Installing $(randColor rofi-blezz) ..."
# $PWD/rofi-blezz/install.sh &>>/tmp/dotfiles.log; echoDone
echo -ne "\t\t Installing $(randColor Firefox) ... "
$PWD/firefox/install.sh &>>/tmp/dotfiles.log; echoDone
echo -ne "\t\t Installing $(randColor Discord) ... "
$PWD/discord/install.sh &>>/tmp/dotfiles.log; echoDone
echo -ne "\t\t Installing $(randColor "Sublime Text") ... "
$PWD/sublime-text/install.sh &>>/tmp/dotfiles.log; echoDone

##  ███    ███ ██    ██ ███████ ██  ██████ 
##  ████  ████ ██    ██ ██      ██ ██      
##  ██ ████ ██ ██    ██ ███████ ██ ██      
##  ██  ██  ██ ██    ██      ██ ██ ██      
##  ██      ██  ██████  ███████ ██  ██████ 

echo -e "\t Installing music software:"
echo -ne "\t\t Installing $(randColor mpd) & $(randColor beets)... "
sudo apt-get -qq install mpd mpc mpdscribble beets &>>/tmp/dotfiles.log; echoDone
# echo -ne "\t\t Installing $(randColor ncmpcpp)... "
# $PWD/ncmpcpp/install.sh &>>/tmp/dotfiles.log; echoDone

##  ███    ███ ██ ███████  ██████    
##  ████  ████ ██ ██      ██         
##  ██ ████ ██ ██ ███████ ██         
##  ██  ██  ██ ██      ██ ██         
##  ██      ██ ██ ███████  ██████ ██ 

echo -e "\t Installing misc. software:"
sudo apt-get -qq install deluge-gtk &>>/tmp/dotfiles.log
echo -ne "\t\t Installing $(randColor Steam)... "
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections
sudo dpkg --add-architecture i386
sudo apt-get -qq update &>>/tmp/dotfiles.log
sudo apt-get -qq install steam mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 &>>/tmp/dotfiles.log
echoDone

echo -ne "\t\t Installing $(randColor vlc), $(randColor gimp), & $(randColor inkscape)... "
sudo apt-get -qq install vlc gimp inkscape &>>/tmp/dotfiles.log
echoDone
