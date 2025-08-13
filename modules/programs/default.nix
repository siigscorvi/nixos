{ config, lib, pkgs, ... }:
{
  imports = [
    ./spotify.nix
    ./spotify-cli.nix
    ./networkmanager.nix
    ./zathura.nix

    ./nh.nix
    ./git.nix
    ./thunderbird.nix
    ./terminal
    ./alacritty.nix
    ./kitty.nix
    ./soundgui.nix
    ./thunar.nix
  ];

  # all of these should be optional
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
    bitwarden-desktop
    # this needs to move to a module!
    sshfs
    rofi-wayland
    # this is no longer necessary with hyprland. Make it optional
    arandr

    python313
  ];
  programs.zathura.enable = true;
}
