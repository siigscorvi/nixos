#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash
xrandr --output HDMI-0 --mode 1920x1080 --pos 0x180 --rotate normal --output DP-0 --primary --mode 2560x1440 --rate 180 --pos 1920x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off
