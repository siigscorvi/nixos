{ pkgs, vars, ... }:

let
  hypr-reload = pkgs.writeShellScriptBin "hypr-reload" ''
    hyprctl reload > /tmp/reload-log.txt
    systemctl --user restart waybar > /tmp/reload-log.txt
    hyprctl hyprpaper reload ,"~/.config/wallpapers/current" > /tmp/reload-log.txt
    notify-send "Reload Finished" "See /tmp/reload-log.txt for more info"
  '';

in {
  environment.systemPackages = [ hypr-reload ];
}
