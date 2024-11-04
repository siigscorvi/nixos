{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    tigervnc
    virtualgl # not sure if necessary but keeping it for now
    xorg.libXdamage
  ];
}
