#!/bin/env bash

DAY=6500
NIGHT=5000

CUR=$(busctl --user -- get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | grep -oE '[0-9]+')

if [[ $CUR == $DAY ]]; then
    busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $NIGHT
else
    busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $DAY
fi
