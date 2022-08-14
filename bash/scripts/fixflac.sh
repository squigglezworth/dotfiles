#!/bin/bash

# find . -type f -name '*.flac' | parallel -j4 fixflac.sh

p="$@"
echo -ne "Checking $(basename "${p}")...\033[0K\r"
if ! flac -t -s "$p" &>> fixflac.log; then
    echo -e "\nCorrupted! Trying to fix..."
    echo "$p" >> fixflac.files
    if ! flac -s -f "$p" &>> fixflac.log; then
        echo "Failed to fix :("
    fi
fi
