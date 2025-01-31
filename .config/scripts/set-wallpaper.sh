#!/bin/bash
work_path="$1"
files=($(find $work_path -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \)))
file_count=${#files[@]}
number=$(($RANDOM % $file_count))
feh --bg-fill --no-fehbg ${files[$number]}
