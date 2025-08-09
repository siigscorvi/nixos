{
  config.system.desktop = {
    hyprland = {

      monitors = ''
        monitor=desc:Lenovo Group Limited R27qe UP331C79,2560x1440@180.08,auto,1
        monitor=desc:Acer Technologies GN276HL T6BEE0018501,preferred,auto-left,1
        monitor=,preferred,auto-left,1
      '';

      workspace-rules = ''
        # workspaces
        workspace = name:1, monitor:desc:Lenovo Group Limited R27qe UP331C79, default:true
        workspace = name:2, monitor:desc:Acer Technologies GN276HL T6BEE0018501, default:true
        workspace = name:3, monitor:desc:Acer Technologies GN276HL T6BEE0018501
        workspace = name:4, monitor:desc:Acer Technologies GN276HL T6BEE0018501
        workspace = name:5, monitor:desc:Acer Technologies GN276HL T6BEE0018501
        workspace = name:6, monitor:desc:Acer Technologies GN276HL T6BEE0018501
        workspace = name:7, monitor:desc:Acer Technologies GN276HL T6BEE0018501
        workspace = name:8, monitor:desc:Lenovo Group Limited R27qe UP331C79
        workspace = name:9, monitor:desc:Lenovo Group Limited R27qe UP331C79
        workspace = name:0, monitor:desc:Acer Technologies GN276HL T6BEE0018501
      '';

      extra-settings = ''
        windowrule = opacity 0.8, class:^(kitty)$
      '';
      inactive-transparency = 1.0;
      blur = true;
      shadow = true;
      animations = true;
    };

    hypridle = {
      lockwarning-timeout = 260;
      screendimming-beforelock-timeout = 0;
      lock-timeout = 300;
      screendimming-locked-timeout = 0;
      blankscreen-timeout = 30;
      sleep-timeout = 299;
    };

    hyprlock.background.style = "screenshot";

    waybar = {
      battery = false;
      output = "DP-3";
    };

  };
}
