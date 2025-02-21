{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    pkgs.python312Packages.west
    nrf5-sdk
    nrfutil
    #nrfconnect
    cmake

  ];

  shellHook = ''
    zsh
    echo "casa shell"
  '';
}
