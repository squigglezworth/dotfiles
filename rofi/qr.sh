#!/usr/bin/env bash

# shopt -s nullglob globstar
if [[ -z "$@" ]]; then
	echo -n "Enter text to generate QR code with"
else
	exec 1>&-
	qrencode -s 10 --background=181818 --foreground=b9b9b9 -o - "$@" | feh --title "floating" -
fi
