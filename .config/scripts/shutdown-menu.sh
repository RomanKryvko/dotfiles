#!/bin/bash

INPUT=$(echo -e 'CANCEL\nSHUTDOWN\nREBOOT\nSLEEP\nEXIT I3' | rofi -dmenu -config $HOME/.config/rofi/rofi.rasi)

case $INPUT in
	"SHUTDOWN")
	shutdown -P now
	;;

	"SLEEP")
	systemctl suspend
	;;
	
	"REBOOT")
	reboot
	;;

	"EXIT I3")
	i3-msg exit
	;;
esac
