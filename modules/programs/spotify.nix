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
}
