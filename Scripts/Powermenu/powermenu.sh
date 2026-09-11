#!/usr/bin/env bash

chosen=$(printf \
"󰌾  Lock\n󰍃  Logout\n󰤄  Suspend\n󰒲  Hibernate\n󰜉  Reboot\n󰐥  Shutdown" \
| rofi -dmenu -i -p "Power: ")

case "$chosen" in
    "󰌾  Lock")
        hyprlock
        ;;
    "󰍃  Logout")
        hyprctl dispatch exit
        ;;
    "󰤄  Suspend")
        systemctl suspend
        ;;
    "󰒲  Hibernate")
        systemctl hibernate
        ;;
    "󰜉  Reboot")
        systemctl reboot
        ;;
    "󰐥  Shutdown")
        systemctl poweroff
        ;;
esac
