{ config, lib, vars, pkgs, inputs, ... }:
with lib;
let cfg = config.system.desktop.hyprland;
in {
  imports = [ ./hypridle.nix ./waybar.nix ];

  options.system.desktop.hyprland.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable Hyprland as the Wayland compositor";
  };
  # TODO: add this option to hyprlock module, when ready
  # options.hyprlock.fingerprint.enable = mkEnableOption "Fingerprint authentication for Hyprlock";

  config = mkIf cfg.enable {

    programs.uwsm.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    programs.hyprlock.enable = true;

    # home-manager.users.${vars.username} = {
    #   home.file.".config/hypr/hyprland.conf" = {
    #     source = ../../../configs/hyprland.conf;
    #   };
    # };

    environment.systemPackages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      hyprpaper
      hyprpolkitagent
      rofi-wayland
      wl-clipboard-rs
    ];

  };
}
