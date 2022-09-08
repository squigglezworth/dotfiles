#!/bin/bash
# This script orchestrates installing & configuring various software to initialize my home system, including my desktop environment, system settings, and various software like Steam & Discord
# 
# `install.sh` installs packages with apt, and calls program-specific install scripts to build some software
# `config.sh` links various config files, and also handles things like restarting services when appropriate
#
# This script is destructive and you probably shouldn't run it

set -a
echo ".dotfiles init"
if [[ "$@" != "auto" ]]; then
   read -p "This script will overwrite existing files. Are you sure you want to run it? (Yes)"
   if [[ ! $REPLY =~ ^Yes$ ]]; then
      exit 1
   fi
else
   export LASTFM_USERNAME="squigglezworth"
   export LASTFM_PASSWORD="foo"
fi

# Import colors, exporting for future use
[ -f $HOME/dotfiles/bash/colors ] && source $HOME/dotfiles/bash/colors
[ -f $HOME/dotfiles/bash/scripts/color-utils.sh ] && source $HOME/dotfiles/bash/scripts/color-utils.sh

# Gather user input, exporting for future use
[ ! LASTFM_USERNAME ] && read -ep "Enter last.fm username: " LASTFM_USERNAME
[ ! LASTFM_PASSWORD ] && read -esp "Enter last.fm password: " LASTFM_PASSWORD; echo;

sudo echo -n

echoDone() { echo -e "${BGreen}Done!${Color_Off}" ; }
set +a

# Move to `dotfiles`
cd $(dirname -- $0)/..

echo -e $(randColor "Let's do it!")
echo -ne "\nInitial apt update ... "
sudo apt-get -qq update &>>/tmp/dotfiles.log
sudo apt-get -qq dist-upgrade &>>/tmp/dotfiles.log
echoDone

echo -e "\nInstalling:"
.setup/install.sh

echo -e "\nConfiguring:"
.setup/config.sh

echo -e $(rainbow "All done! \o/")

echo -e "Don't forget to restore sensitive files such as SSH keys!"
if [ -f /mnt/usb/.restore.sh ]; then
   read -p "Restore script found! Would you like to run it?"
   if [[ $REPLY =~ [Yy] ]]; then
      /mnt/usb/.restore.sh
   fi
fi

rm ~/.init

read -p "Would you like to reboot? (Y/y)"
if [[ $REPLY =~ [Yy] ]]; then
   echo -n "${BRed}Rebooting ... "
   secs=5
   while [ $secs -gt 0 ]; do
      echo -ne "${BRed}Rebooting ... $secs \033[0K\r${Color_Off}"
      sleep 1
      ((secs--))
   done
   sudo reboot
fi
