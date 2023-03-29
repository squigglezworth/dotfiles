#!/bin/bash
# ID, exe
STEAM_FOLDER=/home/squigz/.steam/steam/steamapps

cd $STEAM_FOLDER/compatdata/$1/

export STEAM_COMPAT_CLIENT_INSTALL_PATH=/home/squigz/.steam
export STEAM_COMPAT_DATA_PATH=$PWD
export WINEPREFIX=$PWD/pfx

$STEAM_FOLDER/common/Proton\ 6.3/proton run $2
