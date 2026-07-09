#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'usrctl') ]]; then
    /usr/bin/eww open usrctl && /usr/bin/eww update ctlrev=true
else
    if [[ $(eww get ctlrev) == true ]]; then
        /usr/bin/eww update ctlrev=false
        (sleep 0.35 && [[ $(eww get ctlrev) == false ]] && /usr/bin/eww close usrctl) &
    else
        /usr/bin/eww update ctlrev=true
    fi
fi
