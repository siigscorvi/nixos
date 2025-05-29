{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    timeout = 2;
    efi.canTouchEfiVariables = true;
  };

  services.blueman.enable = true;

  services.udev.packages = [ pkgs.nrf-udev pkgs.openocd pkgs.segger-jlink ];

  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.firewall = { allowedUDPPorts = [ 52810 ]; };
  networking.wg-quick.interfaces.wg0 = {
    configFile = "/etc/wireguard/wg0.conf";
    autostart = true;
  };

  nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-810" ];
  nixpkgs.config.segger-jlink.acceptLicense = true;

  # default dir setup
  environment.sessionVariables = {
    XDG_DESKTOP_DIR = "$HOME/documents/";
    XDG_DOCUMENTS_DIR = "$HOME/documents/";
    XDG_DOWNLOAD_DIR = "$HOME/downloads";
    XDG_MUSIC_DIR = "$HOME/music";
    XDG_PICTURES_DIR = "$HOME/images";
    XDG_PUBLICSHARE_DIR="$HOME/nc";
    XDG_VIDEOS_DIR = "$HOME/videos";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 75; # 75 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 90; # 90 and above it stops charging

    };
  };

}
