#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'menuctl') ]]; then
    /usr/bin/eww open menuctl && /usr/bin/eww update menurev=true
else
    if [[ $(eww get menurev) == true ]]; then
        /usr/bin/eww update menurev=false
        (sleep 0.35 && [[ $(eww get menurev) == false ]] && /usr/bin/eww close menuctl) &
    else
        /usr/bin/eww update menurev=true
    fi
fi
