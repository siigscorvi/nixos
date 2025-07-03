{
# Service include daemons, systemd service and so on
  imports = [
    #./syncthing.nix
    ./ssh.nix
    ./spotify-player-sleepinhibit.nix
    ./spotify-player-autostart.nix
    ./sound.nix
    ./samba.nix
    ./nextcloud.nix
    ./kdeconnect.nix

    ./fingerprint.nix
    #./ollama.nix
  ];
}
