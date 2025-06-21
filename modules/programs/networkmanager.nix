{ config, lib, vars, pkgs, ...}:
# config to enable network manager applet and gui.

with lib;
let cfg = config.system.programs.nm-frontends;
in {

  options.system.programs.nm-frontends = {
    enable-gui = mkOption {
      type = types.bool;
      default = true;
      description = "";
    };

    enable-applet = mkOption {
      type = types.bool;
      default = false;
      description = "Wether to enable network manager applet";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable-gui {
        environment.systemPackages = [ pkgs.networkmanagerapplet ];
    })

    (mkIf cfg.enable-applet {
      programs.nm-applet.enable = true;
    })
  ];
}

