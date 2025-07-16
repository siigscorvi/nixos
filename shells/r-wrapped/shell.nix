{ pkgs, ... }:
pkgs.mkShell {
  packages = with pkgs;
    [
      (rWrapper.override {
        packages = with rPackages; [ languageserversetup ggplot2 dplyr ];
      })
    ];
  shellHook = ''
    zsh
  '';
}
