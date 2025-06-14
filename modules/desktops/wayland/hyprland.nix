{ config, lib, vars, pkgs, ... }:
with lib;
let cfg = config.system.desktop.hyprland;
in {
  options.system.desktop.hyprland.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable Hyprland as the Wayland compositor";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    home-manager.users.${vars.username} = {
      home.file.".config/hypr/hyprland.conf" = {
        source = ../../../configs/hyprland.conf;
      };
    };

    environment.systemPackages = [
      pkgs.hyprpaper
    ];

  };
}
