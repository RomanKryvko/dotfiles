#!/bin/env bash

# CMDs
uptime="`uptime | sed -e 's/^.*up[ \t].//' -e 's/,.*$//'`"
host=`hostnamectl hostname`

# Options
shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"
log_out="󰍃  Log out"

rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -config ~/.config/rofi/powermenu.rasi
}

exit_cmd() {
    case $XDG_SESSION_DESKTOP in
        'sway')
            swaymsg exit
            ;;
        'i3')
            i3-msg exit
            ;;
        *)
            loginctl kill-session $XDG_SESSION_ID
            ;;
    esac
}

INPUT=$(echo -e "$lock\n$suspend\n$reboot\n$shutdown\n$log_out" | rofi_cmd)

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

    $log_out)
        exit_cmd
        ;;

    $lock)
        loginctl lock-session
        ;;
esac
