{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "de";

    windowManager.i3.enable = true;

    displayManager.lightdm.enable = true;
  };

  hardware.brillo.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
  ];



}
