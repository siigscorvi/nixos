{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qjackctl
  ];
}
