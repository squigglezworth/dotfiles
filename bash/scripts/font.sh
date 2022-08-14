#!/usr/bin/env bash
origsize=`appres urxvt | grep '\*font:' | awk '{print $2}' | awk -F: '{print $3}' | awk -F= '{print $2}'`
origfont=`appres urxvt | grep '\*font:' | awk '{print $2}' | awk -F: '{print $2}'`
if [[ ! $1 =~ ^-?[0-9]+$ ]]
then
    newfont=$1
    if [ -z $2 ]
    then
        newsize=$origsize
    else
        newsize=$2
    fi
else
    newfont=$origfont
    newsize=$1
fi

printf '\33]50;%s%d\007' "xft:$newfont:size=" $newsize
