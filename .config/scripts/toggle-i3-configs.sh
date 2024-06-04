#!/bin/bash
oldConfig="$HOME/.config/i3/old_config"
config="$HOME/.config/i3/config"
tmp="$HOME/.config/i3/temp"
mv $config $tmp
mv $oldConfig $config
mv $tmp $oldConfig
#rm $tmp
i3-msg restart
