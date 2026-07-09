#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'musicctl') ]]; then
    /usr/bin/eww open musicctl && /usr/bin/eww update musicctlrev=true
else
    if [[ $(eww get musicctlrev) == true ]]; then
        /usr/bin/eww update musicctlrev=false
        (sleep 0.35 && [[ $(eww get musicctlrev) == false ]] && /usr/bin/eww close musicctl) &
    else
        /usr/bin/eww update musicctlrev=true
    fi
fi
