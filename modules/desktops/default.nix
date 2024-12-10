{ config, lib, ... }:
{
  imports = [
    ./i3.nix # this should always be enabled - for now
    ./picom.nix
    ./thunar.nix
    ./lock.nix # this should be enablable
    ./applets.nix
    ./lightdm.nix
    ./polybar.nix
    ./xserver.nix # this should always be enabled
    ./notifier.nix
    ./alacritty.nix
    ./soundgui.nix
  ];

}
