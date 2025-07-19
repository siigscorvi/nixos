{ pkgs, ... }:
{
# What are the parts of a desktop?

  imports = [
    ./login-manager.nix
    ./stylix.nix
    ./wayland
    ./X/xserver.nix
  ];
  environment.systemPackages = with pkgs; [
    libnotify
  ];
}
