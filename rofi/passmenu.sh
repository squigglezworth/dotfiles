#!/usr/bin/env bash
export QT_STYLE_OVERRIDE=gtk2


shopt -s nullglob globstar
if [[ -z "$@" ]]
    then
    prefix=${PASSWORD_STORE_DIR-~/.password-store}
    password_files=( "$prefix"/**/*.gpg )
    password_files=( "${password_files[@]#"$prefix"/}" )
    password_files=( "${password_files[@]%.gpg}" )

    printf '%s\n' "${password_files[@]}"
else
    exec 1>&-
    password="$1"
    pass -c "$1"
    notify-send "Copied password '$1' to clipboard" " Will clear in ${PASSWORD_STORE_CLIP_TIME} seconds"
fi

