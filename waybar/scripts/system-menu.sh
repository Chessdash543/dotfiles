#!/bin/bash

entries="  Logout
  Suspend
  Reboot
  Shutdown"

chosen=$(echo "$entries" | wofi -d -W 280 -p "" -b -c ~/.config/wofi/config 2>/dev/null)

case "$chosen" in
  *"Logout")
    hyprctl dispatch exit 2>/dev/null || loginctl terminate-user "$USER"
    ;;
  *"Suspend")
    systemctl suspend &
    sleep 1
    pkill waybar 2>/dev/null
    ;;
  *"Reboot")
    systemctl reboot
    ;;
  *"Shutdown")
    systemctl poweroff
    ;;
esac
