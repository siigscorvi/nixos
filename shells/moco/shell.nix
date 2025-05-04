{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gcc
    glibc.dev
    gnumake42

    (python3.withPackages(p: with p; [
      matplotlib
      numpy
      geopy
    ]))

  ];
  shellHook = ''
    zsh
  '';
}
