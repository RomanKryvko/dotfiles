#!/bin/bash

#X = 0, Y = 1
DIMENS=($(cat /sys/class/graphics/fb0/virtual_size | awk 'BEGIN {FS=","} {print $1, $2}'))

if [ ! -z $1 ]; then
    IMG=$1
else
    FILES=($(find $HOME/Pictures/Wallpapers -type f \( -name "*.jp*g" -o -name "*.png" -o -name "*.webp" \)))
    FILE_COUNT=${#FILES[@]}
    NUMBER=$(($RANDOM % $FILE_COUNT))
    IMG=${FILES[$NUMBER]}
fi

#X = 0, Y = 1
IMG_DIMENS=($(exiv2 $IMG 2> /dev/null | awk '/Image size/ {print $4, $6}'))

if [[ ${IMG_DIMENS[0]} -ge ${DIMENS[0]} && ${IMG_DIMENS[1]} -ge ${DIMENS[1]} ]]; then
    MODE="-f preserveAspectCrop"    #image is both too wide and too tall
elif [[ ${IMG_DIMENS[0]} -gt ${DIMENS[0]} ]]; then
    MODE="-f preserveAspectCrop"    #image is too wide
elif [[ ${IMG_DIMENS[1]} -gt ${DIMENS[1]} ]]; then
    MODE="-f preserveAspectFit"     #image is too tall
fi

plasma-apply-wallpaperimage $IMG $MODE
