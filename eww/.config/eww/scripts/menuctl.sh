#!/bin/bash

if [[ -z $(eww active-windows | grep 'menuctl') ]]; then
    /usr/bin/eww open menuctl && /usr/bin/eww update menurev=true
elif [[ $(eww get menurev) == true ]]; then
    /usr/bin/eww update menurev=false
else
    /usr/bin/eww update menurev=true
fi
