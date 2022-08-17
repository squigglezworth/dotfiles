#!/bin/bash
set -e
## ███████ ██    ██ ███████ ████████ ███████ ███    ███ 
## ██       ██  ██  ██         ██    ██      ████  ████ 
## ███████   ████   ███████    ██    █████   ██ ████ ██ 
##      ██    ██         ██    ██    ██      ██  ██  ██ 
## ███████    ██    ███████    ██    ███████ ██      ██ 

echo -e "\t Configuring system:"
echo -ne "\t\t Installing crontab ... "
crontab $PWD/cron; echoDone
if ! grep -f $PWD/fstab /etc/fstab >/dev/null ; then
    echo -ne "\t\t Installing fstab ... "
    cat $PWD/fstab | sudo tee -a /etc/fstab >/dev/null; echoDone
else
    echo -e "\t\t fstab already installed, skipping!"
fi
echo -ne "\t\t Configuring mounts ... "
sudo systemctl daemon-reload
sudo mkdir -p /mnt/disk-{1,2,3} /mnt/usb{,2} /mnt/misc
sudo chown -R squigz:squigz /mnt/
for i in disk-{1,2,3} usb; do mount /mnt/$i; done
echoDone
echo -ne "\t\t Configuring autologin ... "
sudo cp -a $PWD/systemd/autologin.conf /etc/systemd/system/getty@tty1.service.d/
echoDone
echo -ne "\t\t Configuring tops (top, atop, htop) ... "
rm -rf $HOME/.config/procps $HOME/.config/htop $HOME/.atoprc
mkdir -p $HOME/.config/procps/ $HOME/.config/htop/
ln -fs $PWD/tops/toprc $HOME/.config/procps/toprc
ln -fs $PWD/tops/htoprc $HOME/.config/htop/htoprc
ln -fs $PWD/tops/atoprc $HOME/.atoprc
echoDone

##  ██████  ███████ ███████ ██   ██ ████████  ██████  ██████  
##  ██   ██ ██      ██      ██  ██     ██    ██    ██ ██   ██ 
##  ██   ██ █████   ███████ █████      ██    ██    ██ ██████  
##  ██   ██ ██           ██ ██  ██     ██    ██    ██ ██      
##  ██████  ███████ ███████ ██   ██    ██     ██████  ██      

echo -e "\t Configuring desktop environment:"
echo -ne "\t\t Copying fonts ... "
rm -f $HOME/.bashrc $HOME/.bash_profile
ln -fs $PWD/bash/bashrc $HOME/.bashrc
ln -fs $PWD/bash/bash_profile $HOME/.bash_profile
echoDone
echo -ne "\t\t Copying fonts ... "
rm -rf $HOME/.fonts/
ln -fs $PWD/fonts/ $HOME/.fonts; echoDone
echo -ne "\t\t Configuring X ... "
rm -f $HOME/.Xresources $HOME/.xinitrc
ln -fs $PWD/X/Xresources $HOME/.Xresources; ln -fs $PWD/X/xinitrc $HOME/.xinitrc; echoDone
echo -ne "\t\t Configuring bash ... "
rm -f $HOME/.bashrc
ln -fs $PWD/bash/bashrc $HOME/.bashrc; echoDone
echo -ne "\t\t Configuring i3 ... "
rm -rf $HOME/.i3/
ln -fs $PWD/i3/ $HOME/.i3; echoDone
echo -ne "\t\t Configuring polybar ... "
rm -rf $HOME/.config/polybar/
ln -fs $PWD/polybar/ $HOME/.config/polybar; echoDone
echo -ne "\t\t Configuring wallpaper ... "
rm -f $HOME/.fehbg
ln -fs $PWD/feh $HOME/.fehbg; echoDone
echo -ne "\t\t Configuring dunst ... "
rm -rf $HOME/.config/dunst/
ln -fs $PWD/dunst/ $HOME/.config/dunst; echoDone
# echo -ne "\t\t Configuring Firefox ... "
# rm -rf $HOME/.mozilla/
# mkdir -p $HOME/.mozilla; ln -fs $PWD/firefox/firefox/ $HOME/.mozilla/firefox; echoDone
echo -ne "\t\t Configuring vim ... "
rm -rf $HOME/.vim $HOME/.vimrc
ln -fs $PWD/vim/vimrc $HOME/.vimrc
ln -fs $PWD/vim/vim $HOME/.vim
echoDone
# echo -ne "\t\t Configuring sublime ... "
# rm -rf $HOME/.config/sublime-text
# ln -fs $PWD/sublime-text/ $HOME/.config/sublime-text; echoDone
echo -ne "\t\t Configuring rofi-blezz ... "
rm -rf $HOME/.config/blezz
ln -fs $PWD/rofi-blezz/ $HOME/.config/blezz; echoDone
echo -ne "\t\t Configuring pulsemixer ... "
rm -rf $HOME/.config/pulsemixer.cfg
ln -fs $PWD/pulsemixer/pulsemixer.cfg $HOME/.config/pulsemixer.cfg; echoDone
echo -ne "\t\t Configuring PulseEffects ... "
rm -rf $HOME/.config/PulseEffects
ln -fs $PWD/PulseEffects/ $HOME/.config/PulseEffects; echoDone
echo -ne "\t\t Configuring conky ... "
rm  -rf $HOME/.config/conky
ln -fs $PWD/conky/ $HOME/.config/conky; echoDone

##  ███    ███ ██    ██ ███████ ██  ██████ 
##  ████  ████ ██    ██ ██      ██ ██      
##  ██ ████ ██ ██    ██ ███████ ██ ██      
##  ██  ██  ██ ██    ██      ██ ██ ██      
##  ██      ██  ██████  ███████ ██  ██████ 

echo -e "\t Configuring music software:"
echo -ne "\t\t Configuring ncmpcpp ... "
rm -rf $HOME/.config/ncmpcpp
ln -fs $PWD/ncmpcpp/ $HOME/.config/ncmpcpp; echoDone
echo -ne "\t\t Configuring beets ... "
rm -rf $HOME/.config/beets
ln -fs $PWD/beets/ $HOME/.config/beets; echoDone
echo -ne "\t\t Configuring mpd ... "
sudo systemctl disable --now mpd &>>/tmp/dotfiles.log
systemctl --user enable mpd &>>/tmp/dotfiles.log
rm -rf $HOME/.config/mpd
ln -fs $PWD/mpd/ $HOME/.config/mpd
systemctl --user start mpd &>>/tmp/dotfiles.log
mpc update &>>/tmp/dotfiles.log
echoDone
echo -ne "\t\t Configuring mpdscribble ... "
rm -rf $HOME/.mpdscribble; mkdir $HOME/.mpdscribble
sudo cat /etc/mpdscribble.conf | tee $HOME/.mpdscribble/mpdscribble.conf >/dev/null
sed -i "s/^username \=/username = $LASTFM_USERNAME/" $HOME/.mpdscribble/mpdscribble.conf
sed -i "s/^password \=/password = $LASTFM_PASSWORD/" $HOME/.mpdscribble/mpdscribble.conf
systemctl --user enable --now mpdscribble &>>/tmp/dotfiles.log
echoDone
