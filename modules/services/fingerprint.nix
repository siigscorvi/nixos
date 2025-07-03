{ pkgs, vars, lib, config, ... }:

with lib;
let cfg = config.system.fingerprint;
in {
  options.system.fingerprint = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Wether to enable the fingerprint scanner module";
    };

    tod = mkOption {
      type = types.bool;
      default = true;
      description = "Wether to enable the Touch OEM Drivers library";
    };


    driver = mkPackageOption pkgs "libfprint-2-tod1-goodix-550a" {
      default = [ "libfprint-2-tod1-goodix-550a" ];
    };

    start-on-boot = mkOption {
      type = types.bool;
      default = false;
      description = "Enable autostart on boot of fingerprint scanner module";
    };
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;

    services.fprintd.tod.enable = cfg.tod;
    services.fprintd.tod.driver = cfg.driver;

    systemd.services.fprintd = mkIf cfg.start-on-boot {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
    };

  };

}
