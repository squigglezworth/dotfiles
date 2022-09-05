#!/bin/bash

# TODO cleaner way of going up a dir, hopefully with a keybind

while [ 1 ]; do
    # Build a list of files/directories
    IFS=$'\n' f=('Move up one dir ..' $(cdu -risdhD "."/*))
    
    # Present the list to the user, store their selection for later
    n=$(echo "${f[*]}" | fzf --ansi --preview='cd {3..}; cdu -risdhD ./*' --reverse)
    
    # Required to Ctrl-C without spamming it
    test $? -eq 130 && break

    # Finally, navigate to the user's selection, setting the PWD for the next iteration
    cd $(echo "$n" | awk '{print $NF}')
done
