# this should contain everything that can/should not be exported to a module or is not hardware related
{ pkgs, config, host }:

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

  # this is just a gui
  services.blueman.enable = true;

  networking = {
    interfaces = {
      enp4s0 = {
        wakeOnLan = {
          enable = true;
          policy = [ "magic" ];
        };
      };
    };
  };

  
}
