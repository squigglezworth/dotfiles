#!/bin/bash

if [ $(xprop WM_CLASS -id $(xdotool getwindowfocus) | sed 's/^.*".*", "\(.*\)"/\1/') == "Sublime_text" ]; then
    /usr/bin/subl --command "show_overlay {\"overlay\": \"goto\", \"show_files\": true}"
fi
