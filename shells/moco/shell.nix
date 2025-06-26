{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gcc
    glibc.dev
    gnumake42

    esptool
    espflash

    (python3.withPackages(p: with p; [
      matplotlib
      meshtastic
      esptool
    ]))

  ];
  shellHook = ''
    zsh
  '';
}
