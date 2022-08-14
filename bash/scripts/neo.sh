#!/bin/bash
xterm -e "neo -l 1,2 -G 10 -b 0" &
sleep 0.1; i3-msg [class="XTerm"] fullscreen
