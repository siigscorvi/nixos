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
    gperf
    ccache
    dfu-util
    tk-8_5
    segger-jlink-headless
    segger-jlink
    zulu23
    nrf-udev

    python312Packages.pip
    python312Packages.west
    python312Packages.wheel
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
