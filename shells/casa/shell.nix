{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    pandoc
    quarto
    texliveFull
    R


    rPackages.ggplot2
    rPackages.quarto
    rPackages.rmarkdown
    rPackages.tinytex
  ];
  shellHook = ''
    zsh
    echo "casa shell"
  '';
}

