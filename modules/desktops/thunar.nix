{ pkgs, config, lib, ... }:

with lib;
let cfg = config.desktop.thunar; in
{
  options.desktop.thunar = {
    enable = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = "enable thunar";
   };
  };

  config = mkIf cfg.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
          thunar-media-tags-plugin
        ];
      };
      xfconf.enable = true;
    };

    services.gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome.gvfs;
    };

    services.tumbler.enable = true;

    environment.systemPackages = with pkgs; [
      file-roller
      lxqt.lxqt-policykit 
    ];
  };
}
