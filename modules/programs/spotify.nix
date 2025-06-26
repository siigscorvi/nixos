{ pkgs, vars, lib, config, ... }:

with lib;
let
  cfg = config.programs.spotify-gui;
in
{

  options.programs.spotify-gui = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable spotify player";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
