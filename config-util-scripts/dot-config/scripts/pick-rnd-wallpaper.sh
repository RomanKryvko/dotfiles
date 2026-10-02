#!/bin/env bash

WALLPAPER_PATH=~/Pictures/Wallpapers/
files=($(find $WALLPAPER_PATH -type f \( -name "*.jpeg" -o -name "*.jpg" -o -name "*.png" -o -name "*.webp" \)))
file_count=${#files[@]}
number=$(($RANDOM % $file_count))
echo ${files[$number]}
