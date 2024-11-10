{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polybar
  ];
}
