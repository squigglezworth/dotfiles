#!/bin/bash

colorList() {
    for w in "$@"; do
        printf '\e[38;5;%dm%s\e[0m ' "$((RANDOM%15+1))" "$w"
    done
    printf '\033[1D'
}

randColor() {
    printf '\e[38;5;%dm%s\e[0m' "$((RANDOM%15+1))" "$*"
}
