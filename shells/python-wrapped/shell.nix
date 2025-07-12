
{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    (python312.withPackages(p: with p; [
      yfinance
    ]))
  ];
  shellHook = ''
    zsh
  '';
}
