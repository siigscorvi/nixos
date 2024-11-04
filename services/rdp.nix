{ pkgs, config, ... }:
{
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "none+i3";
  services.xrdp.openFirewall = true;
}
