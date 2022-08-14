#!/bin/bash

clear
while true;
do 
    if ping -i .2 -w 1 -c 1 google.com >/dev/null 2>&1; then
        echo -ne "\r\033[0K"
        tput setf 2
        echo -ne "Success\t\t"
        echo -n `date +%S`
        tput sgr0
    else
        sleep 1
        if ! ping -i .2 -w 1 -c 1 google.com >/dev/null 2>&1; then
            tput setf 1
            echo -ne "\a\nPinging\t\t"
            echo `date +%R:%S`
            tput sgr0
        fi
    fi
done
