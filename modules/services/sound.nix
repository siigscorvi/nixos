{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.playerctld.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
  ];
}
