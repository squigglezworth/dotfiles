#!/bin/bash

# Fix for xdg-desktop-portal 'Failed to start Portal Service'
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Pulseaudio crap
/home/squigz/dotfiles/bash/scripts//pulseaudio-rename.sh
    # && pacmd 'update-sink-proplist alsa_output.pci-0000_0a_00.3.analog-stereo device.description="Headset"'\
    # && pacmd 'update-source-proplist alsa_input.pci-0000_0a_00.3.analog-stereo device.description="Headset"'\
    # && pacmd 'update-sink-proplist alsa_output.pci-0000_06_00.0.analog-stereo device.description="Speakers"'\
    # && pacmd 'update-source-proplist alsa_input.pci-0000_06_00.0.analog-stereo device.description="Speakers"'\
    # && pacmd 'unload-module 3'\
    # && pacmd 'unload-module 2'\
    # && pacmd 'update-sink-proplist alsa_output.usb-Kingston_HyperX_Virtual_Surround_Sound_00000000-00.analog-stereo device.description="HyperX"'\
    # && pacmd 'update-source-proplist alsa_output.usb-Kingston_HyperX_Virtual_Surround_Sound_00000000-00.analog-stereo device.description="HyperX"'\
    # && pacmd 'update-sink-proplist alsa_output.pci-0000_08_00.1.hdmi-stereo device.description="TV"'
    # && pacmd 'update-source-proplist alsa_output.pci-0000_08_00.1.hdmi-stereo device.description="TV"'

# Setup displays (moved to .xinitrc)
#~/.screenlayout/screens.sh
# Set wallpaper (moved to .xinitrc)
#/home/squigz/.fehbg

# Start status bar
polybar -r default &

# Configure stuff
xset s off -dpms
xrdb .Xresources
# Add multi mountpoint
#mhddfs /mnt/disk-* /mnt/evo-* /mnt/multi
# Setup mouse
#     Kensington
i="Kensington      Kensington Expert Mouse"
xinput set-button-map "$i" 8 2 3 4 5 6 7 1
xinput set-prop "$i" "libinput Accel Speed" -0.5

# Make sure PulseEffects starts before continuing
pulseeffects --gapplication-service &

# Setup main workspace
#i3-msg "workspace 1:Chat; append_layout /home/squigz/.i3/layout-main.json"
discord &
#mumble &
#slack &
#teamspeak &
#urxvt -name "irc" -e bash -c 'ssh squigz.ruun.network -t tmux attach -t weechat' &
#urxvt -name "log" -e bash -c 'sudo dmesg -w; bash' &
#urxvt -name "top-tile" -e bash -c 'top; bash' &
#urxvt -name "ping" -e bash -c '~/ping.sh; bash' &

# Everything else
/usr/bin/firefox &
subl &
STEAM_COMPAT_MOUNTS=/mnt/disk-2/game-libraries/EVE/ steam &
#plex &
flameshot &
parcellite &
dunst &
unclutter -idle 10 &

#conky -c .conky/default.conf -d &

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# Start at workspace 1
i3-msg "workspace 1:Chat"
