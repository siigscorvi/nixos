
{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages(p: with p; [
      git-filter-repo
    ]))
  ];
  shellHook = ''
    zsh
  '';
}
