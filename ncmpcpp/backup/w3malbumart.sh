#!/bin/bash
MUSIC_DIR="/home/squigz/music"
PANE_WIDTH=`tput cols`
PANE_HEIGHT=`tput lines`

FONTH=15 # Size of one terminal row
FONTW=8 # Size of one terminal column

PANE_WIDTH=`tput cols`
PANE_HEIGHT=`tput lines`
PANE_X=$(tmux display -p '#{pane_left}')
PANE_Y=$(tmux display -p '#{pane_top}')

X=$(expr $PANE_X \* $FONTW)
Y=$(expr $PANE_Y \* $FONTH)
WIDTH=$(expr $PANE_WIDTH \* $FONTW)
HEIGHT=$(expr $PANE_HEIGHT \* $FONTH)

while :; do
    CURRENT_FILE=$(mpc current -f "%file%")
    CURRENT_DIR=$(dirname "$CURRENT_FILE")
    CURRENT_ALBUM="$(mpc --format %album% current )"
    
    FILES="$(find $MUSIC_DIR/"$CURRENT_DIR" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${CURRENT_ALBUM}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
    COVER="$(echo -n "$FILES" | head -n1)"
    echo "Drawing image $COVER with geography ${WIDTH}x${HEIGHT}+${X}+${Y}"
    w3m_command="0;1;$X;$Y;100;100;;;;;"""$COVER"""\n4;\n3;"
    echo "$w3m_command"
    tput cup $(($HEIGHT/$FONTH)) 0
    echo -e $w3m_command | /usr/lib/w3m/w3mimgdisplay
    exit
    mpc idleloop message &>/dev/null
    mpc idle player update
    mpc waitmessage refresh_album
    clear
done
