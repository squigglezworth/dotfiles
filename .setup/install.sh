#!/bin/bash
set -e
## ███████ ██    ██ ███████ ████████ ███████ ███    ███ 
## ██       ██  ██  ██         ██    ██      ████  ████ 
## ███████   ████   ███████    ██    █████   ██ ████ ██ 
##      ██    ██         ██    ██    ██      ██  ██  ██ 
## ███████    ██    ███████    ██    ███████ ██      ██ 

echo -ne "\t Installing system tools ... "
sudo apt-get -qq install bash-completion apt-transport-https atop default-jre dnsutils gpg kleopatra pinentry-qt libnotify-bin htop iotop lshw net-tools nethogs procps software-properties-common tmux vim wget &>>/tmp/dotfiles.log
echoDone

echo -ne "\t Enabling non-free/contrib repos ... "
sudo apt-add-repository non-free &>>/tmp/dotfiles.log
sudo apt-add-repository contrib &>>/tmp/dotfiles.log
echoDone

if lspci | grep NVIDIA &>/dev/null; then
    echo -ne "\t Installing GPU drivers ... "
    sudo apt-get -qq update &>>/tmp/dotfiles.log
    sudo apt-get -qq install nvidia-driver firmware-misc-nonfree &>>/tmp/dotfiles.log
    echoDone
fi

##  ██████  ███████ ███████ ██   ██ ████████  ██████  ██████  
##  ██   ██ ██      ██      ██  ██     ██    ██    ██ ██   ██ 
##  ██   ██ █████   ███████ █████      ██    ██    ██ ██████  
##  ██   ██ ██           ██ ██  ██     ██    ██    ██ ██      
##  ██████  ███████ ███████ ██   ██    ██     ██████  ██      

echo -e "\t Installing desktop environment:"
LIST="arandr breeze breeze-gtk-theme dunst feh flameshot fonts-hack fonts-noto-color-emoji lxappearance nemo parcellite polybar pass pulseeffects pulsemixer qt5ct ranger rofi rxvt-unicode-256color xinit"
echo -ne "\t\t Installing basic utils ($(colorList $LIST)) ... "
sudo apt-get -qq install $LIST &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "i3-gaps") ... "
$PWD/i3/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "Firefox") ... "
$PWD/firefox/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "Discord") ... "
$PWD/discord/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "Sublime Text") ... "
$PWD/sublime-text/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "fzf") ... "
$PWD/fzf/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "picom") ... "
$PWD/picom/install.sh &>>/tmp/dotfiles.log; echoDone

# echo -e "\t\t Installing $(randColor "rofi-blezz") ..."
# $PWD/rofi-blezz/install.sh &>>/tmp/dotfiles.log; echoDone

##  ███    ███ ██    ██ ███████ ██  ██████ 
##  ████  ████ ██    ██ ██      ██ ██      
##  ██ ████ ██ ██    ██ ███████ ██ ██      
##  ██  ██  ██ ██    ██      ██ ██ ██      
##  ██      ██  ██████  ███████ ██  ██████ 

echo -e "\t Installing music software:"
echo -ne "\t\t Installing $(randColor "mpd") & $(randColor "beets") ... "
sudo apt-get -qq install mpd mpc mpdscribble beets &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "ncmpcpp") ... "
$PWD/ncmpcpp/install.sh &>>/tmp/dotfiles.log; echoDone

##  ███    ███ ██ ███████  ██████    
##  ████  ████ ██ ██      ██         
##  ██ ████ ██ ██ ███████ ██         
##  ██  ██  ██ ██      ██ ██         
##  ██      ██ ██ ███████  ██████ ██ 

echo -e "\t Installing misc. software:"
sudo apt-get -qq install deluge-gtk &>>/tmp/dotfiles.log
echo -ne "\t\t Installing $(randColor "Steam") ... "
$PWD/steam/install.sh &>>/tmp/dotfiles.log; echoDone

echo -ne "\t\t Installing $(randColor "vlc"), $(randColor "gimp"), & $(randColor "inkscape") ... "
sudo apt-get -qq install vlc gimp inkscape &>>/tmp/dotfiles.log; echoDone
