#!/bin/bash

# Fix for xdg-desktop-portal 'Failed to start Portal Service'
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Pulseaudio
/home/squigz/dotfiles/bash/scripts/pulseaudio-rename.sh
pulseeffects --gapplication-service &

# Desktop utils & whatnot
picom &
polybar -r default &
polybar -r scroller &
unclutter -idle 10 &
dunst &
flameshot &
parcellite &
#conky -c .conky/default.conf -d &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# Configure stuff
xset s off -dpms
xrdb .Xresources

# Setup mouse
i="Kensington      Kensington Expert Mouse"
xinput set-button-map "$i" 8 2 3 4 5 6 7 1
xinput set-prop "$i" "libinput Accel Speed" -0.5

# Everything else
discord &
/usr/bin/firefox &
subl &
STEAM_COMPAT_MOUNTS=/mnt/disk-2/game-libraries/EVE/ steam &
