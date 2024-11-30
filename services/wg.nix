{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.enable = true;

#  networking.wireguard.interfaces = {
#    wg0 = {
#      ips = [ "10.13.13.5/32" ];
#      listenPort = 51820; 
#      privateKeyFile = "/home/siigs/.config/wg/privateKeyFile";
#
#      peers = [
#
#        {
#          publicKey = "6a2cIVSPaFXTDg1HMeoZEw6esX1HkXM63gxzxULbCwc=";
#          presharedKeyFile = "/home/siigs/.config/wg/presharedKeyFile";
#
#          allowedIPs = [ "10.13.13.1/32" "192.168.42.0/24" ];
#
#          endpoint = "siigs.de:51820";
#          persistentKeepalive = 25;
#        }
#      ];
#    };
#  };



}
