{ config, ...}:

{
  config.system.desktop = {
    hyprland = {
        monitors = ''
          monitor=eDP-1,preferred,auto,1.333333
          monitor=desc:Lenovo Group Limited R27qe UP331C79,preferred,auto-up,1.0666666
          monitor=,preferred,auto-up,1
        '';
        workspace-rules = ''
          # workspaces
          workspace = name:1, monitor:eDP-1, default:true
          workspace = name:2, monitor:desc:Lenovo Group Limited R27qe UP331C79, default:true
          workspace = name:3, monitor:desc:Lenovo Group Limited R27qe UP331C79
          workspace = name:4, monitor:desc:Lenovo Group Limited R27qe UP331C79
          workspace = name:5, monitor:desc:Lenovo Group Limited R27qe UP331C79
          workspace = name:6, monitor:desc:Lenovo Group Limited R27qe UP331C79
          workspace = name:7, monitor:desc:Lenovo Group Limited R27qe UP331C79
          workspace = name:8, monitor:eDP-1,
          workspace = name:9, monitor:eDP-1,
          workspace = name:0, monitor:desc:Lenovo Group Limited R27qe UP331C79
        '';
        swapcaps = true;
      };

    waybar = {
      battery = true;
      output = "eDP-1";
    };
    hyprlock = {
      fingerprint = true;
    };


  };
}
