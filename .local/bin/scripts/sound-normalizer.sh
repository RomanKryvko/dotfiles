#!/bin/bash
# Rounds the default sink volume to be divisible by STEP

if [ ! -z $1 ] ; then
    if ! [[ $1 =~ ^[0-9]$ ]]; then
        echo "Volume step must be a digit."
        exit 1
    fi
    STEP=$1
else
    STEP=5
fi

CUR_VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oE [0-9]+% | head -1)
CUR_VOL=${CUR_VOL::-1}

function get_nearest_divisible() {
    local i=$CUR_VOL
    local j=$CUR_VOL
    while true; do
        if [ $(($i % $STEP)) == 0 ]; then
            echo $i
            return
        fi

        if [ $(($j % $STEP)) == 0 ]; then
            echo $j
            return
        fi

        i=$(($i+1))
        j=$(($j-1))
    done
}

if [ $(($CUR_VOL % $STEP)) != 0 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ $(get_nearest_divisible)%
fi

