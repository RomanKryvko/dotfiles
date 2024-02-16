#!/bin/bash

INPUT=$(echo -e 'CANCEL\nSHUTDOWN\nREBOOT\nSLEEP\nEXIT I3' | rofi -dmenu)

case $INPUT in
	"SHUTDOWN")
	shutdown -P now
	;;

	"SLEEP")
	systemctl hibernate
	;;
	
	"REBOOT")
	reboot
	;;

	"EXIT I3")
	i3-msg exit
	;;
esac
