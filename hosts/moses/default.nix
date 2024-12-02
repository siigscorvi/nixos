{ pkgs, config, host, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    timeout = 2;
    efi.canTouchEfiVariables = true;
  };

  services.blueman.enable = true;

}
