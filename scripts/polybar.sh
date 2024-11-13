#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Terminate already running bar instances
# pkill -x polybar
# If all your bars have ipc enabled, you can also use
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar primary 2>&1 | tee -a /tmp/polybar1.log & disown
polybar secondary 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
