#!/bin/bash

while [ 1 ]; do
    echo -ne "Loading...\r"

    # Build a list of files/directories
    IFS=$'\n' f=($(du -sh | awk '{print $1 "\t" Total}') $(echo -en "Move up one dir\t..") $(cdu -sidhD * | tac))
    
    # Present the list to the user, store their selection for later
    n=$(echo -n "${f[*]}" | fzf \
        --ansi \
        --header-lines=1 \
        --color="header:bright-white" \
        --preview='cd {3..} && cdu -sidhD * | tac') \
        # --bind='bs:preview(echo "Loading...")+reload(cd .. && cdu -sidhD * | tac)') \
    
    # Required to Ctrl-C without spamming it
    [ $? -eq 130 ] && break

    # Finally, navigate to the user's selection, setting the PWD for the next iteration
    f=$(echo "$n" | awk '{print $NF}')
    [ "$f" == ".." ] && cd .. && continue
    [ -d "$f" ] && cd "$f"
done
