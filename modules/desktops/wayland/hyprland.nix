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

    environment.systemPackages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      hyprpaper
      hyprpolkitagent
      rofi-wayland
      wl-clipboard-rs
    ];

    home-manager.users.${vars.username} = {

      home.file.".config/hypr/hyprpaper.conf" = {
        force = true;
        text = ''
          preload = /home/siigs/.config/wallpapers/current
          wallpaper = , /home/siigs/.config/wallpapers/current
        '';
      };

    };

  };
}
