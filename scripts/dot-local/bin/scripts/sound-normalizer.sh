#!/bin/env bash
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

CUR_VOL=$(wpctl get-volume @DEFAULT_SINK@ | awk '{match($0, /[0-9]+\.?[0-9]+$/, a); print a[0] * 100}')

function get_nearest_divisible() {
    if [ $1 -le $(($STEP / 2)) ]; then
        echo $(($CUR_VOL - $1))
    else
        echo $(($CUR_VOL - $1 + $STEP))
    fi
}

REM=$(($CUR_VOL % $STEP))

if [ $REM != 0 ]; then
    wpctl set-volume @DEFAULT_SINK@ $(get_nearest_divisible $REM)%
fi

