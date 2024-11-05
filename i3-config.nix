{config, pkgs, home-manager, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    dex
  ];

  services.xserver.windowManager.i3.configFile =./configfiles/i3_config;

}
