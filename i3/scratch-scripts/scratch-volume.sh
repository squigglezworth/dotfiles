#!/bin/bash
i3-msg '[class="^URxvt$" instance="volume"] scratchpad show' || urxvt -name "volume" -e bash -c 'pulsemixer --color 1'

#out=`xlsclients -l | grep volume`
#if [ ! "$out" ]
#then
#	nohup urxvt -name "volume-control" -e "volume-control.sh" &
#	sleep .1
#	i3-msg [title="volume"] floating enable, resize set $(echo "1920-(1920/4*2)" | bc) px $(echo "1080-(1080/10*5)" | bc), move position center, move scratchpad, scratchpad show
#else
#	i3-msg [title="volume"] scratchpad show
#fi
