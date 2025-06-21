{ pkgs, ... }:
{
  imports = [
    ./i3.nix
    ./lock.nix
    ./picom.nix
    ./polybar.nix
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "de";

    windowManager.i3.enable = true;

    displayManager.lightdm.enable = false;
  };

  environment.systemPackages = with pkgs; [
    xclip
    dunst
  ];

}
