#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'musicctl') ]]; then
    /usr/bin/eww open musicctl && /usr/bin/eww update musicctlrev=true
else
    /usr/bin/eww update musicctlrev=false
    (sleep 0.2 && /usr/bin/eww close musicctl) &
fi
