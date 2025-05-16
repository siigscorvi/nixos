{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    go
    hugo
    dart-sass
  ];
  shellHook = ''
    zsh
  '';
}
