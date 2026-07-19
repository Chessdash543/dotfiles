#!/bin/bash

PAMIXER="/usr/bin/pamixer"
EWW="/usr/bin/eww"

vol=$($PAMIXER --get-volume)
mute=$($PAMIXER --get-mute)

if [ "$mute" = true ]; then
    $EWW update volico="󰖁"
    $EWW update get_vol="0"
    echo "0"
else
    $EWW update volico="󰕾"
    $EWW update get_vol="$vol"
    echo "$vol"
fi

pactl subscribe | stdbuf -oL grep --line-buffered "Event 'change' on sink" | while read -r _; do
    vol=$($PAMIXER --get-volume)
    mute=$($PAMIXER --get-mute)
    if [ "$mute" = true ]; then
        $EWW update volico="󰖁"
        $EWW update get_vol="0"
        echo "0"
    else
        $EWW update volico="󰕾"
        $EWW update get_vol="$vol"
        echo "$vol"
    fi
done
