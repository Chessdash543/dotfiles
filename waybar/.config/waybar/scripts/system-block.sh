#!/bin/bash

# Battery
battery_info=$(upower -i $(upower -e | grep BAT) 2>/dev/null)
battery_pct=$(echo "$battery_info" | grep "percentage:" | awk '{print $2}' | tr -d '%')
battery_status=$(echo "$battery_info" | grep "state:" | awk '{print $2}')

if [ -z "$battery_pct" ]; then
  battery_text=""
  battery_icon=""
else
  if [ "$battery_status" = "charging" ]; then
    battery_icon=""
  elif [ "$battery_pct" -ge 80 ]; then
    battery_icon=""
  elif [ "$battery_pct" -ge 60 ]; then
    battery_icon=""
  elif [ "$battery_pct" -ge 40 ]; then
    battery_icon=""
  elif [ "$battery_pct" -ge 20 ]; then
    battery_icon=""
  else
    battery_icon=""
  fi
  battery_text="$battery_pct% $battery_icon"
fi

# Volume
vol_info=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+(?=%)' | head -1)
vol_mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -oP '(?<=Mute: )(yes|no)')

if [ -n "$vol_info" ]; then
  if [ "$vol_mute" = "yes" ]; then
    volume_text=""
  elif [ "$vol_info" -ge 50 ]; then
    volume_text=" $vol_info%"
  elif [ "$vol_info" -gt 0 ]; then
    volume_text=" $vol_info%"
  else
    volume_text=""
  fi
else
  volume_text=""
fi

# Build output
parts=()
[ -n "$battery_text" ] && parts+=("$battery_text")
[ -n "$volume_text" ] && parts+=("$volume_text")

text=""
for i in "${!parts[@]}"; do
  [ $i -gt 0 ] && text+="  "
  text+="${parts[$i]}"
done

# Determine class
class="system-block"
if [ -n "$battery_pct" ] && [ "$battery_pct" -le 15 ] && [ "$battery_status" != "charging" ]; then
  class="system-block critical"
fi

echo "{\"text\": \"$text\", \"class\": \"$class\"}"
