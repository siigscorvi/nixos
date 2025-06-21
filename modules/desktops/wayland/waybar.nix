{ config, lib, vars, pkgs, ... }:
with lib;
let cfg = config.system.desktop.waybar;
in {

  options.system.desktop.waybar = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hypridle for managing idle states in Hyprland";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };

    # home-manager.users.${vars.username} = {
    #   home.file.".config/hypr/waybar.conf" = {
    #     text = ''
    #       general {
    #         lock_cmd = pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock
    #         before_sleep_cmd = loginctl lock-session
    #         after_sleep_cmd = hyprctl dispatch dpms on
    #
    #         ignore_dbus_inhibit = false
    #         ignore_systemd_inhibit = false
    #       }
    #
    #       ${if cfg.lockwarning-timeout == 0 then "" else ''
    #       # idle warning
    #       listener {
    #         timeout = ${toString cfg.lockwarning-timeout}
    #         on-timeout = notify-send "session about to be locked"
    #       }
    #       ''}
    #
    #       ${if cfg.screendimming-beforelock-timeout == 0 then "" else ''
    #       # while not locked, save brightness and drim screen
    #       # return brightness on input
    #       listener {
    #         timeout = ${toString cfg.screendimming-beforelock-timeout}
    #         on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock || brillo -O && brillo -S 10%
    #         on-resume = pidof ${pkgs.hyprlock}/bin/hyprlock || brillo -I
    #       }
    #       ''}
    #
    #       ${if cfg.lock-timeout == 0 then "" else ''
    #       # lock session
    #       listener {
    #         timeout = ${toString cfg.lock-timeout}
    #         on-timeout = loginctl lock-session
    #       }
    #       ''}
    #
    #       ${if cfg.screendimming-locked-timeout == 0 then "" else ''
    #       # while locked, dim screen
    #       # return brightness on input
    #       listener {
    #         timeout = ${toString cfg.screendimming-locked-timeout}
    #         on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && brillo -S 10%
    #         on-resume = pidof ${pkgs.hyprlock}/bin/hyprlock && brillo -I
    #       }
    #       ''}
    #
    #       ${if cfg.blankscreen-timeout == 0 then "" else ''
    #       # while locked, turn off the display
    #       # turn display back on on input
    #       listener {
    #         timeout = ${toString cfg.blankscreen-timeout}
    #         on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && hyprctl dispatch dpms off
    #         on-resume = hyprctl dispatch dpms on
    #       }
    #       ''}
    #
    #       ${if cfg.sleep-timeout == 0 then "" else ''
    #       # while locked, suspend
    #       listener {
    #         timeout = ${toString cfg.sleep-timeout}
    #         on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && systemctl suspend
    #       }
    #       ''}
    #     '';
    #   };
    # };
  };
}

