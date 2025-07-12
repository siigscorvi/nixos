{ config, lib, vars, pkgs, ... }:
with lib;
let cfg = config.system.desktop.hypridle;
in {

  options.system.desktop.hypridle = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hypridle for managing idle states in Hyprland";
    };
    lockwarning-timeout = mkOption {
      type = types.int;
      default = 100;
      description = "Timeout in seconds before showing a lock warning";
    };
    screendimming-beforelock-timeout = mkOption {
      type = types.int;
      default = 110;
      description = "Timeout in seconds before dimming the screen";
    };
    lock-timeout = mkOption {
      type = types.int;
      default = 120;
      description = "Timeout in seconds before the locking the session";
    };
    screendimming-locked-timeout = mkOption {
      type = types.int;
      default = 10;
      description = "Timeout in seconds before dimming the screen while locked";
    };
    blankscreen-timeout = mkOption {
      type = types.int;
      default = 30;
      description =
        "Timeout in seconds before blanking the screen while locked";
    };
    sleep-timeout = mkOption {
      type = types.int;
      default = 180;
      description = "Timeout in seconds before going to sleep while locked";
    };
  };

  config = mkIf cfg.enable {

    home-manager.users.${vars.username} = {
      home.file.".config/hypr/hypridle.conf" = {
        text = ''
          general {
            lock_cmd = pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock
            before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
            after_sleep_cmd = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on

            ignore_dbus_inhibit = false
            ignore_systemd_inhibit = false
          }

          ${if cfg.lockwarning-timeout == 0 then
            ""
          else ''
            # idle warning
            listener {
              timeout = ${toString cfg.lockwarning-timeout}
              on-timeout = ${pkgs.libnotify}/bin/notify-send "session about to be locked"
            }
          ''}

          ${if cfg.screendimming-beforelock-timeout == 0 then
            ""
          else ''
            # while not locked, save brightness and drim screen
            # return brightness on input
            listener {
              timeout = ${toString cfg.screendimming-beforelock-timeout}
              on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.brillo}/bin/brillo -O && ${pkgs.brillo}/bin/brillo -S 10%
              on-resume = pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.brillo}/bin/brillo -I
            }
          ''}

          ${if cfg.lock-timeout == 0 then
            ""
          else ''
            # lock session
            listener {
              timeout = ${toString cfg.lock-timeout}
              on-timeout = ${pkgs.systemd}/bin/loginctl lock-session
            }
          ''}

          ${if cfg.screendimming-locked-timeout == 0 then
            ""
          else ''
            # while locked, dim screen
            # return brightness on input
            listener {
              timeout = ${toString cfg.screendimming-locked-timeout}
              on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && ${pkgs.brillo}/bin/brillo -S 10%
              on-resume = pidof ${pkgs.hyprlock}/bin/hyprlock && ${pkgs.brillo}/bin/brillo -I
            }
          ''}

          ${if cfg.blankscreen-timeout == 0 then
            ""
          else ''
            # while locked, turn off the display
            # turn display back on on input
            listener {
              timeout = ${toString cfg.blankscreen-timeout}
              on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
              on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
            }
          ''}

          ${if cfg.sleep-timeout == 0 then
            ""
          else ''
            # while locked, suspend
            listener {
              timeout = ${toString cfg.sleep-timeout}
              on-timeout = pidof ${pkgs.hyprlock}/bin/hyprlock && ${pkgs.systemd}/bin/systemctl suspend
            }
          ''}
        '';
      };
    };
  };
}

