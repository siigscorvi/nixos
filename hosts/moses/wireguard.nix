{ pkgs, ... }:

{
  networking.firewall = {
    allowedUDPPorts = [
      52810
    ];
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];

#  networking.wg-quick.interfaces = {
#      wg0 = {
#        address = [ "10.125.125.2/32" ];
#        dns = [ "10.125.125.1" ];
#        privateKeyFile = "/etc/wireguard/wg0_key";
#        
#        peers = [
#          {
#            publicKey = "OwcH4g8TkWqFfsIdONLl+d5HcXSed6Lh2CxhUmEiaTs=";
#            presharedKeyFile = "/etc/wireguard/wgLan_preShared";
#            allowedIPs = [ "0.0.0.0/0" ];
#            endpoint = "wg.siigs.de:52810";
#          }
#        ];
#      };
#      wg1 = {
#        address = [ "10.125.125.3/32" ];
#        dns = [ "10.125.125.1" ];
#        privateKeyFile = "/etc/wireguard/wg1_key";
#        
#        peers = [
#          {
#            publicKey = "OwcH4g8TkWqFfsIdONLl+d5HcXSed6Lh2CxhUmEiaTs=";
#            presharedKeyFile = "/etc/wireguard/wgLan_preShared";
#            allowedIPs = [ "10.42.42.0/24" "10.125.125.0/24" ];
#            endpoint = "wg.siigs.de:52810";
#          }
#        ];
#      };
#    };
}
