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

  hardware.brillo.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
    dunst
  ];

  # moved from applets.nix
  programs.nm-applet.enable = true;

}
