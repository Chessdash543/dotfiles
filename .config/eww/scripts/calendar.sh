#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'calendar') ]]; then
    /usr/bin/eww open calendar && /usr/bin/eww update calrev=true
else
    /usr/bin/eww update calrev=false
    /usr/bin/eww close calendar
fi
