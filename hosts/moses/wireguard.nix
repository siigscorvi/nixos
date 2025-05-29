{ pkgs, ... }:

{
  networking.firewall = {
    allowedUDPPorts = [
      52810
    ];
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];
}
