{
  config.system.desktop = {
    hyprland = {
        monitors = ''
          monitor=desc:Lenovo Group Limited R27qe UP331C79,preferred,auto-up,1.0666666
          monitor=,preferred,auto-left,1
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
        inactive-transparency = 0.9;
        blur = true;
        shadow = true;
        animations = true;
      };

    hyprlock.background.style = "screenshot";

    waybar = {
      battery = false;
      output = "eDP-1";
    };


  };
}
