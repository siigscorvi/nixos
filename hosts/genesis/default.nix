# this should contain everything that can/should not be exported to a module or is not hardware related
{ pkgs, config, host, ... }:

{
  imports = [ ./hardware-configuration.nix ./desktop.nix ];

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

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  hardware.xone.enable = true;

  environment.systemPackages = with pkgs; [ mangohud protonup wireguard-tools ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH =
      "/home/siigs/.steam/root/compatibilitytools.d";
  };

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

  services.xserver.videoDrivers = [ "nvidia" ];

  # changes for pg
  services.udev.packages = [ pkgs.nrf-udev pkgs.openocd ];

}
