{ pkgs, ... }:

let
  hypr-reload = pkgs.writeShellScriptBin "hypr-reload" ''
    hyprctl reload > /tmp/reload-log.txt
    systemctl --user restart waybar > /tmp/reload-log.txt
    systemctl --user restart hypridle.service > /tmp/reload-log.txt
    hyprctl hyprpaper reload ,"~/.config/wallpapers/current" > /tmp/reload-log.txt
    notify-send "Reload finished" "see /tmp/reload-log.txt for more info"
  '';

in {
  environment.systemPackages = [ hypr-reload ];
}
