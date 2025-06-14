{ config, lib, pkgs, ... }:
{
  imports = [
    ./nh.nix
    ./git.nix
    ./spotify.nix
    ./thunderbird.nix
    ./terminal

    ./alacritty.nix
    ./kitty.nix
    ./soundgui.nix
    ./thunar.nix
  ];

  environment.systemPackages = with pkgs; [
    drawio
    anki

    pandoc
    texlive.combined.scheme-full
    discord
    vlc
    firefox

    xournalpp
    openvpn
    openssl
    # this needs to move to a module!
    rofi
    rofi-wayland
    arandr

    python313

    zathura
  ];
}
