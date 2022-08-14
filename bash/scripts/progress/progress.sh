#!/usr/bin/env bash

function progress_gen() {
    filled=$1
    total=$2
    progress_bar=""
    rest=""
    beg="["
    end="]"
    bar_length=50
    filled_length=$(printf "%.0f" $(echo "$bar_length * $filled / $total" | bc -l))
    rest=$(echo "$bar_length - $filled_length" | bc -l)
    progress_bar=$beg$(printf %${filled_length}s | sed -e "s/ /─/g")$(printf %${rest}s | sed -e "s/ /-/g")$end
}

for i in {1..100}
do
    progress_gen $i 100
    notify-send.sh -a progress -R ./notification.file "test" -- $progress_bar
done
