{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    nrf5-sdk
    nrfutil
    nrf-command-line-tools
    nrfconnect
    cmake
    ninja
    dtc

    python312Packages.pip
  ];

  shellHook = ''
    cd ~/nc/uni/5sem/pg/ble-framework
    echo "================================================== \n
                    DO NOT FORGET TO ENTER VENV \n
          =================================================="
    source ~/nc/uni/5sem/pg/ble-framework/.ble-venv/bin/activate
    zsh
  '';
}
