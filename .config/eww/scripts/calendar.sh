#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'calendar') ]]; then
    /usr/bin/eww open calendar && /usr/bin/eww update calrev=true
else
    if [[ $(eww get calrev) == true ]]; then
        /usr/bin/eww update calrev=false
        (sleep 0.35 && [[ $(eww get calrev) == false ]] && /usr/bin/eww close calendar) &
    else
        /usr/bin/eww update calrev=true
    fi
fi
