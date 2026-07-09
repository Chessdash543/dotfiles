#!/bin/bash

sleep 0.1

if [[ -z $(eww active-windows | grep 'wifictl') ]]; then
    /usr/bin/eww open wifictl && /usr/bin/eww update wifictlrev=true
else
    if [[ $(eww get wifictlrev) == true ]]; then
        /usr/bin/eww update wifictlrev=false && /usr/bin/eww update wificonfigrev=false
    else
        /usr/bin/eww close wifictl
    fi
fi
