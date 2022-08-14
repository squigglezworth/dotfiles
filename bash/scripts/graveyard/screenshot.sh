#!/bin/bash

# Requires imagemagick, curl, basic unix utilities, scrot, xrandr
function progress_gen() {
    filled=$1
    total=$2

    bar_length=40
    filled_length=$(printf "%.0f" $(echo "$bar_length * $filled / $total" | bc -l))
    rest=$(echo "$bar_length - $filled_length" | bc -l)
    progress_bar=$(printf %${filled_length}s | sed -e "s/ /─/g")
    progress_bar=$progress_bar$(printf %${rest}s | sed -e "s/ /-/g")
}
function upload() {
    if [[ ! -z $1 ]]
        then
        $(curl --progress-bar -F c=@${1} -F p=1 -F sunset=86400 https://plop.pw/ &>/tmp/curl.progress) &
        while [ 1 ]
        do
            if [[ $(wc -l </tmp/curl.progress) -ge 2 ]]
                then
                url=$(cat /tmp/curl.progress | tail -n-2 | head -n1 | cut -c6-)
                notify-send.sh -s $(cat /tmp/curl.notification)
                break
            else
                while IFS='' read -r line || [[ -n "$line" ]]; do
                    value=$(echo ${line: -6} | tr -d '[:space:]')
                    value=${value%.*}
                done < /tmp/curl.progress

                progress_gen ${value} 100
                notify-send.sh -a progress -R /tmp/curl.notifcation "test" -- "$progress_bar"
                unset progress_bar
                notify-send.sh -a progress -R /tmp/curl.notification -h int:value:${value} "Uploading screenshot" "${progressbar}"
                sleep .5
            fi
        done
        notify-send.sh -R /tmp/curl.notification "Screenshot taken" "${url}" && \
        echo -n $url | xclip -i
        rm /tmp/curl.notification
        rm /tmp/curl.progress
    fi
}

function mainfunc() {
    exec 1>&-
    cd ~/screenshots/
    if [[ $1 =~ ^-?[0-9]+$ ]]
        then
        num=$(($1-1))
        IFS=$'\n'
        disps=($(xrandr | grep -e "\sconnected" | awk {'printf ("%s %s %s %s\n", $1, $2, $3, $4)'}))
        IFS=$' '
        disp=($(echo -n "${disps[$num]}" | awk {'printf ("%s %s %s %s", $1, $2, $3, $4)'}))
        file=~/screenshots/`date +'%d-%m-%Y_%H:%M:%S'`_${disp[0]}.png
        if [[ ${disp[2]} == "primary" ]]
            then
            import -silent -window root -crop "${disp[3]}" "${file}"
        else
            import -silent -window root -crop "${disp[2]}" "${file}"
        fi
        xclip -selection clipboard -t image/png -i "${file}"
        # upload "${file}"
    elif [ "$1" == "Area" ]
        then
        file=~/screenshots/`date +'%d-%m-%Y_%H:%M:%S'`_area.png
        scrot -s $file && \
        xclip -selection clipboard -t image/png -i "${file}"
        # upload "${file}"
    elif [ "$1" == "Active" ]
        then
        file=~/screenshots/`date +'%d-%m-%Y_%H:%M:%S'`_active.png
        scrot -u $file && \
        xclip -selection clipboard -t image/png -i "${file}"
        # upload "${file}"
    elif [ "$1" == "All" ]
        then
        IFS=$'\n'
        file=~/screenshots/`date +'%d-%m-%Y_%H:%M:%S'`_all.png
        disps=($(xrandr | grep -e "\sconnected" | awk {'printf ("%s %s %s %s\n", $1, $2, $3, $4)'}))
        for i in ${disps[*]}
        do
            IFS=$' '
            disp=($(echo -n "$i" | awk {'printf ("%s %s %s %s", $1, $2, $3, $4)'}))
            if [[ ${disp[2]} == "primary" ]]
                then
                import -silent -window root -crop ${disp[3]} disp_"${disp[0]}".png
            else
                import -silent -window root -crop ${disp[2]} disp_"${disp[0]}".png
            fi
        done
        convert -gravity center -background "#121212" +append disp_*.png ${file}
        xclip -selection clipboard -t image/png -i "${file}"
        # upload "${file}"
    else
        IFS=$' '
        disp=($(xrandr | grep $1 | awk {'printf ("%s %s %s %s", $1, $2, $3, $4)'}))
        file=~/screenshots/`date +'%d-%m-%Y_%H:%M:%S'`_${disp[0]}.png
        if [[ ${disp[2]} == "primary" ]]
            then
            import -silent -window root -crop "${disp[3]}" "${file}"
        else
            import -silent -window root -crop "${disp[2]}" "${file}"
        fi
        xclip -selection clipboard -t image/png -i "${file}"
        # upload "${file}"
    fi
}

if [[ -z $@ ]]
    then
    IFS=$'\n'
    disps=($(xrandr | grep -e "\sconnected" | awk {'printf ("%s %s %s\n", $1,$3,$4)'}))
    echo "Area"
    echo "All"
    COLS=$((`tput cols`+2))
    printf %${COLS}s | sed -e "s/ /─/g"
    echo ""
    for i in ${!disps[@]}
    do
        printf "%s" ${disps[$i]} | awk {'printf ("%s\n", $1)'}
    done
else
    mainfunc "$@"
fi
