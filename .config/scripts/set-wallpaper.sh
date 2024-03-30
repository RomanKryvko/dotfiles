#!/bin/bash
#work_path=$HOME/Pictures/Wallpapers 
work_path=$1
files=($(ls $work_path))
file_count=$(ls $work_path | wc -l) 
number=$(($RANDOM % $file_count))
feh --bg-fill $work_path/${files[$number]} 
