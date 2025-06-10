{ config, lib, pkgs, ... }:
with lib;
let cfg = config.system.desktop.displayManager;
in {

  options.system.desktop.displayManager.ly.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable the ly display manager";
  };

  options.system.desktop.displayManager.tuigreet.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable the ly display manager";
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = !(cfg.ly.enable && cfg.greetd.enable);
          message   = "Only one display manager can be enabled at a time.";
        }
      ];
    }

    (mkIf cfg.ly.enable {
      services.displayManager.ly.enable = true;
    })

    (mkIf cfg.tuigreet.enable {
      environment.systemPackages = [ pkgs.greetd.tuigreet ];

      services.greetd = {
        enable = true;
        restart = true;
        settings.default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session  \\
          --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red \\
          --cmd Hyprland";
          user    = "greeter";
        };
      };

      users.users.greeter = {
        isSystemUser = true;
        description  = "Greetd Greeter User";
        shell        = pkgs.bash;
      };
    })
  ];
}
