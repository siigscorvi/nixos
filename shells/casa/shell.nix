{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    pandoc
    quarto
    R

    rPackages.ggplot2
    rPackages.quarto

  ];
}
