{ pkgs, ... }:

pkgs.mkShell {
  packages = [
    pkgs.python312Packages.west

  ];

}
