#!/usr/bin/env bash

declare -A folders
folders[movies]="/mnt/multi/Movies/"
folders[tv]="/mnt/multi/TV"
folders[music]="/mnt/multi/Music"

if [[ -z $@ ]]
then
    printf "%s\n" ${!folders[@]}
else
    if [[ ! -z ${folders[$1]} ]]
    then
        export FOLDER=${folders[$1]}
        urxvt -name floating -e bash -c 'ranger $FOLDER' &
    fi
fi
