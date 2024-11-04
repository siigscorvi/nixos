{config, pkgs, home-manager, ... }:

{
  environment.systemPackages = [
    pkgs.feh
  ];

  services.xserver.windowManager.i3.configFile =./i3/config;

}
