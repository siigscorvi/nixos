{ config, lib, pkgs, ... }:
with lib;
let cfg = config.system.desktop.hyprland;
in
{
  options.system.desktop.hyprland.enable = {
    type = types.bool;
    default = true;
    description = "Enable Hyprland as the Wayland compositor";
  };

  config = mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      }
  };
}
