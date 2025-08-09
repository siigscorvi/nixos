{ config, lib, pkgs, ... }:
with lib;
let cfg = config.system.desktop.login-manager;
in {

  options.system.desktop.login-manager.ly.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable the ly display manager";
  };

  options.system.desktop.login-manager.tuigreet.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable the ly display manager";
  };

  config = mkMerge [
    {
      assertions = [{
        assertion = !(cfg.ly.enable && cfg.tuigreet.enable);
        message = "Only one display manager can be enabled at a time.";
      }];
    }

    (mkIf cfg.ly.enable { services.displayManager.ly.enable = true; })

    (mkIf cfg.tuigreet.enable {
      environment.systemPackages = [ pkgs.tuigreet ];

      services.greetd = {
        enable = true;
        restart = true;
        settings.default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland \
                        --time --remember --remember-session\
                        --theme border=yellow
          '';
          user = "greeter";
        };
      };

      users.users.greeter = {
        isSystemUser = true;
        description = "Greetd Greeter User";
        shell = pkgs.bash;
      };

      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal"; # Without this errors will spam on screen
        # Without these bootlogs will spam on screen
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };

    })
  ];
}
