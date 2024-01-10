#!/bin/zsh

# Useful for a laptop: checks if the output to external monitor is
# connected/disconnected, and toggles internal/external display accordingly.

# Names of `xrandr` outputs for internal and external displays; change as needed
internal=LVDS-1
external=HDMI-1-1

# Send display to external monitor when it is physically connected
if xrandr | grep "${external} connected"; then
    xrandr --output "${external}" --auto
    # Optionally turn off laptop screen to save battery while connected to monitor
    # xrandr --output "${internal}" --off  

# Turn off display to external monitor when it is physically disconnected
else
    xrandr --output "${external}" --off
    # Turn laptop screen back on (if needed)
    xrandr--output "${internal}" --auto
fi

