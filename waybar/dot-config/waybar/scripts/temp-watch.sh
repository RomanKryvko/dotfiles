#!/bin/env bash
wl-gammarelay-rs watch '{t}' | while read -r temp; do

    if (( temp < 5750 )); then # middle between 5000 and 6500
        icon="☾"
    else
        icon="☀"
    fi

    #echo "{\"temp\": $temp, \"icon\": $icon}"
    # text, alt, tooltip, class, percentage
    echo "{\"tooltip\": \""$temp"K\", \"percentage\": $(($temp * 100 / 11500)), \"alt\": \"\", \"class\": \"\"}"
done
