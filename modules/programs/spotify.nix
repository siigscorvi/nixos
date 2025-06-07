{ pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
    (spotify-player.override {
      withAudioBackend = "pulseaudio";
      withMediaControl = true;
      withImage = true;
      withDaemon = true;
      withNotify = true;
      withStreaming = true;
      withSixel = true;
      withFuzzy = true;
    })
  ];

  systemd.user.services.spotify-player = {
    enable = true;
    description = "Spotify Player daemon";

    after = [ "network-online.target" "sound.target" ];
    wants = [ "network-online.target" "sound.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.spotify-player}/bin/spotify_player -d";
      Restart = "on-failure";
    };
  };
}
