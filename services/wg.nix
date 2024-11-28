{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.enable = true;

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.13.13.5/32" ];
    listenports = 51820;

    privateKeyfile = ~/.config/wg/privateKeyFile;

    peers = [
      {
        publicKey = "6a2cIVSPaFXTDg1HMeoZEw6esX1HkXm63gxzxULbCwc=";

        allowedIPs = [ "10.13.13.1/32" "192.168.42.0/24" ];
        endpoint = "siigs.de:58120";

        persistentKeepalive = 25;
      }

    ];
  };



}
