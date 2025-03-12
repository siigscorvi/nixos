{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "de";

    windowManager.i3.enable = true;

    displayManager.lightdm.enable = false;
  };

  hardware.brillo.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
  ];

}
