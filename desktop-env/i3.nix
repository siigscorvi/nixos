{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    dex

    picom
    xborders
  ];

  services.xserver.windowManager.i3.configFile = ../configfiles/i3_config;

}
