#!/bin/bash

# Fix for xdg-desktop-portal 'Failed to start Portal Service'
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Pulseaudio
/home/squigz/dotfiles/bash/scripts/pulseaudio-rename.sh
pulseeffects --gapplication-service &

# Desktop utils & whatnot
polybar -r default &
polybar -r scroller &
sleep 0.5
unclutter -idle 10 &
dunst &
flameshot &
parcellite &
#conky -c .conky/default.conf -d &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# Configure stuff
xset s off -dpms

# Setup mouse
i="Kensington      Kensington Expert Mouse"
# Bottom Left, Top Left, Bottom Right, Wheel Left, Wheel Right(?), ?, ?, Top Right
# 1 - Left, 2 - Middle Click, 3 - Right, 4 - Wheel Up, 5 - Wheel Down
# 6 - ?, 7 - Forward, 8 - Back
xinput set-button-map "$i" 3 2 1 4 5 0 0 0
xinput set-prop "$i" "libinput Accel Speed" -0.5

# Everything else
discord &
firefox &
subl &
/home/squigz/activitywatch/aw-qt &
STEAM_COMPAT_MOUNTS=/mnt/disk-2/game-libraries/EVE/ steam &
