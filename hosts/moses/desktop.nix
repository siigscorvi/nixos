{ config, ...}:

{
  config.system.desktop = {

    waybar = {
      battery = true;
      output = "eDP-1";
    };
    hyprlock = {
      fingerprint = true;
    };


  };
}
