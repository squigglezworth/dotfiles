#!/bin/bash


FILES=~/olympics/*.torrent

for i in $FILES
do
	# transmission-show "$i" | grep "Total"

	SIZE=$(transmission-show "$i" | grep -P "Total Size: (\d*\.\d*.*$)" -o)
	SIZE=${SIZE:12}
	echo ${SIZE//[[:space:]]}
done