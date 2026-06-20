#!/bin/bash

# System info for the message area
hostname=$(hostname)
kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //')
mem_total=$(free -h | awk '/Mem:/ {print $2}')
mem_used=$(free -h | awk '/Mem:/ {print $3}')
os=$(source /etc/os-release 2>/dev/null && echo "$PRETTY_NAME" || echo "Linux")

info=" $hostname  |  $os  |  $kernel  |   $mem_used/$mem_total  |   $uptime"

options="  Lock
  Logout
  Suspend
  Reboot
  Shutdown
  Mute
  Vol -10%
  Vol +10%
  Vol max"

chosen=$(echo "$options" | rofi -dmenu -i -p "⚙" \
  -mesg "$info" \
  -theme-str 'window {width: 360px;}')

case "$chosen" in
  *"Lock")
    hyprlock 2>/dev/null || loginctl lock-session 2>/dev/null
    ;;
  *"Logout")
    hyprctl dispatch exit 2>/dev/null || loginctl terminate-user "$USER"
    ;;
  *"Suspend")
    systemctl suspend &
    sleep 1
    hyprlock 2>/dev/null || true
    ;;
  *"Reboot")
    systemctl reboot
    ;;
  *"Shutdown")
    systemctl poweroff
    ;;
  *"Mute")
    pactl set-sink-volume @DEFAULT_SINK@ 0%
    ;;
  *"-10%")
    pactl set-sink-volume @DEFAULT_SINK@ -10%
    ;;
  *"+10%")
    pactl set-sink-volume @DEFAULT_SINK@ +10%
    ;;
  *"max")
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    ;;
esac
