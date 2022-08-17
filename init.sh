#!/bin/bash
set -e
if [[ "$@" != "yes" ]]; then
   read -p "This script will overwrite existing files. Are you sure you want to run it? (Yes)"
   if [[ ! $REPLY =~ ^Yes$ ]]; then
      exit 1
   fi
fi

# Import colors, exporting for future use
set -a
[ -f $HOME/dotfiles/bash/colors ] && source $HOME/dotfiles/bash/colors
[ -f $HOME/dotfiles/bash/scripts/color-utils.sh ] && source $HOME/dotfiles/bash/scripts/color-utils.sh

# Gather user input, exporting for future use
read -ep "Enter last.fm username: " LASTFM_USERNAME
read -esp "Enter last.fm password: " LASTFM_PASSWORD; echo;
# LASTFM_USERNAME="squigglezworth"
# LASTFM_PASSWORD="test"
sudo echo -n

echoDone() { echo -e "${BGreen}Done!${Color_Off}" ; }
set +a

# Move to `dotfiles`
cd $(dirname -- $0)

echo -e $(randColor "Let's do it!")
echo -ne "\nInitial apt update ... "
sudo apt-get -qq update &>>/tmp/dotfiles.log
sudo apt-get -qq dist-upgrade &>>/tmp/dotfiles.log
echoDone

echo -e "\nInstalling:"
.setup/install.sh

echo -e "\nConfiguring:"
.setup/config.sh

echo -n "${BRed}Rebooting ... "
secs=5
while [ $secs -gt 0 ]; do
   echo -ne "${BRed}Rebooting ... $secs \033[0K\r${Color_Off}"
   sleep 1
   ((secs--))
done
sudo reboot
