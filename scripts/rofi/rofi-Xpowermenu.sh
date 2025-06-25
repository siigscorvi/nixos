#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Power menu script using tofi

CHOSEN=$(printf "Lock\nSuspend\nReboot\nShutdown\nLog Out\nHibernate" | rofi -dmenu -i)

case "$CHOSEN" in
	"Lock") xset s activate;;
	"Suspend") systemctl suspend;;
	"Reboot") reboot ;;
	"Shutdown") poweroff ;;
	"Log Out") pkill xserver;;
	"Hibernate") systemctl hibernate;;
	*) exit 1 ;;
esac
