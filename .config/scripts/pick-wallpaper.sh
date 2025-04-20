#!/bin/bash
work_path=$HOME/Pictures/Wallpapers

files=($(find $work_path -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \)))
file_count=${#files[@]}
number=$(($RANDOM % $file_count))
echo ${files[$number]}
