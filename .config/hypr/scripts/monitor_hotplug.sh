#!/bin/bash

INTERNAL="LVDS-1"
EXTERNAL="HDMI-A-1"

handle() {
  case "$1" in
    monitoradded*|monitorremoved*|"")
      if hyprctl monitors all | grep -q "$EXTERNAL"; then
        hyprctl keyword monitor "$INTERNAL, disable"
        hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
      else
        hyprctl keyword monitor "$INTERNAL, preferred, auto, 1"
        hyprctl keyword monitor "$EXTERNAL, disable"
      fi
      ;;
  esac
}

handle ""

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock 2>/dev/null | while read -r line; do
  handle "$line"
done
