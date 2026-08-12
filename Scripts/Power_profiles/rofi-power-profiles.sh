#!/usr/bin/env bash

# Define options for Rofi
options="  Power Saver (power-saver)\n  Balanced (balanced)\n  Performance (performance)"

# Open Rofi menu
choice=$(echo -e "$options" | rofi -dmenu -p "Power Profile:")

# Evaluate choice and set profile via powerprofilesctl
case "$choice" in
    *power-saver*)   powerprofilesctl set power-saver && dunstify -u low -a "System" "Power Profile" "Mode: Power Saver " -h string:x-dunst-stack-tag:profile ;;
    *balanced*)      powerprofilesctl set balanced    && dunstify -u low -a "System" "Power Profile" "Mode: Balanced " -h string:x-dunst-stack-tag:profile ;;
    *performance*)   powerprofilesctl set performance && dunstify -u low -a "System" "Power Profile" "Mode: Performance " -h string:x-dunst-stack-tag:profile ;;
esac
