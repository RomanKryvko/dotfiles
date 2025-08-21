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
    if [ $1 -le $(($STEP / 2)) ]; then
        echo $(($CUR_VOL - $1))
    else
        echo $(($CUR_VOL - $1 + $STEP))
    fi
}

REM=$(($CUR_VOL % $STEP))

if [ $REM != 0 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ $(get_nearest_divisible $REM)%
fi

