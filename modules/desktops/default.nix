{ config, lib, ... }:
{
  imports = [
    ./thunar.nix
    ./soundgui.nix
    ./ly.nix
    ./xserver.nix # this should always be enabled
    ./alacritty.nix
    ./kitty.nix
  ];
}
