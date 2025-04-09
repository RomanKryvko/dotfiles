#!/bin/bash
work_path="$1"
if [ $2 ]; then
    wp_command="$2"
else
    wp_command="feh --bg-fill --no-fehbg "
fi

files=($(find $work_path -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \)))
file_count=${#files[@]}
number=$(($RANDOM % $file_count))
$wp_command ${files[$number]}
