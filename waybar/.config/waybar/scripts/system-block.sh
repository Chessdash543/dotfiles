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
# Build output
parts=()
[ -n "$battery_text" ] && parts+=("$battery_text")

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
