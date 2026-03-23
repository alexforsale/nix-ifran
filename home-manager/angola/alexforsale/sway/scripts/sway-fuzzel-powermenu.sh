#!/usr/bin/env bash

SELECTION="$(printf "󰌾  Lock\n󰤂  Suspend\n󰍃  Log out\n󰜉  Reboot\n  Shutdown" | fuzzel --dmenu -l 5 -p "Power Menu: " -a top-right -w 15)"

case $SELECTION in
  *"Lock")
    swaylock-fancy;;
  *"Suspend")
    systemctl suspend;;
  *"Log out")
    swaymsg exit;;
  *"Reboot")
    systemctl reboot;;
  *"Shutdown")
    systemctl poweroff;;
esac
