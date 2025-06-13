{
# Service include daemons, systemd service and so on
  imports = [
    #./syncthing.nix
    ./ssh.nix
    ./sound.nix
    ./samba.nix
    ./nextcloud.nix
    ./kdeconnect.nix
    #./ollama.nix
  ];
}
