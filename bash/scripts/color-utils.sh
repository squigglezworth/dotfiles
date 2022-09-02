#!/bin/bash

randNum() {
    shuf -n 1 <(printf %s\\n {1..6} {9..14})
}

colorList() {
    for w in "$@"; do
        printf '\e[38;5;%dm%s\e[0m ' $(randNum) "$w"
    done
    printf '\033[1D'
}

randColor() {
    printf '\e[38;5;%dm%s\e[0m' $(randNum) "$*"
}

rainbow() {
    IFS=''
    [[ "$@" =~ ${@//?/(.)} ]]
    l=( "${BASH_REMATCH[@]:1}" )
    for w in ${l[*]}; do
        printf '\e[38;5;%dm%s\e[0m' $(randNum) "$w"
    done
}

# $a=$1
# shift
# if [[ "$a" =~ ^line(s)?$ ]]; then
#     printf '\e[38;5;%dm%s\e[0m' $(randNum) "$*"
# else if [[ "$a" =~ ^word(s)?$ ]]; then
#     for w in "$@"; do
#         printf '\e[38;5;%dm%s\e[0m ' $(randNum) "$w"
#     done
# else if [[ "$a" =~ ^char(s)?$ ]]; then
#     IFS=''
#     [[ "$@" =~ ${@//?/(.)} ]]
#     l=( "${BASH_REMATCH[@]:1}" )
#     for w in ${l[*]}; do
#         printf '\e[38;5;%dm%s\e[0m' $(randNum) "$w"
#     done
# fi
