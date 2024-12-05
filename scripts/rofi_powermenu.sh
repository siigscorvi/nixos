#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Power menu script using tofi

CHOSEN=$(printf "Lock\nSuspend\nReboot\nShutdown\nLog Out" | rofi -dmenu -i)

case "$CHOSEN" in
	"Lock") exit 1;;
	"Suspend") exit 1;;
	"Reboot") reboot ;;
	"Shutdown") poweroff ;;
	"Log Out") exit 1;;
	*) exit 1 ;;
esac
