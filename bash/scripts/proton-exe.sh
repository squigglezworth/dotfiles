#!/bin/bash
# ID, exe
STEAM_FOLDER=/mnt/disk-2/game-libraries/steam/steamapps

cd $STEAM_FOLDER/compatdata/$1/

export STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/squigz/.steam
export STEAM_COMPAT_DATA_PATH=$PWD
export WINEPREFIX=$PWD/pfx

$STEAM_FOLDER/common/Proton\ \-\ Experimental/proton run $2
