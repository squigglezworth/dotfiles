#!/bin/bash

$(xrandr --listactivemonitors | grep HDMI || xrandr --output 'HDMI-0' --auto --left-of 'DVI-I-1') || xrandr --output 'HDMI-0' --off

pkill polybar
polybar -r default &>/dev/null &
polybar -r scroller &>/dev/null &
~/.fehbg
