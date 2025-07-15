
{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    (python312.withPackages(p: with p; [
      git-filter-repo
    ]))
  ];
  shellHook = ''
    zsh
  '';
}
