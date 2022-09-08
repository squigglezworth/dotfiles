#!/bin/bash
i3-msg '[class="^firefox$" instance="Google Calendar"] scratchpad show' || firefox -P Kiosk --kiosk --new-window calendar.google.com
