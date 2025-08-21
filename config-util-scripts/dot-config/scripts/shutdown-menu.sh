#!/bin/bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostnamectl hostname`

# Options
shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"
exit_i3="󰍃  Exit i3"

rofi_cmd() {
	rofi -dmenu \
		-p "$host" \
		-mesg "Uptime: $uptime" \
		-config ~/.config/rofi/powermenu.rasi
}

INPUT=$(echo -e "$lock\n$suspend\n$reboot\n$shutdown\n$exit_i3" | rofi_cmd)

case $INPUT in
	$shutdown)
	shutdown -P now
	;;

	$suspend)
	systemctl suspend
	;;
	
	$reboot)
	reboot
	;;

	$exit_i3)
	i3-msg exit
	;;

	$lock)
	loginctl lock-session
	;;
esac
