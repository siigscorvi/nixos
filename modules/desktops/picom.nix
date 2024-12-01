{ pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    picom
  ];
  home-manager.users.${vars.username} = {
    home.file.".config/picom/picom.conf" = {
      text = ''
        backend = "glx";
        glx-no-stencil = true;

        # Opacity
        active-opacity = 1; 
        inactive-opacity = 1;
        frame-opacity = 1;

        # Blur
        blur-background = true;
        blur-method = "dual_kawase";
        blur-strength = 4;

        blur-background-exclude = [ ];

        # Fading
        fading = true;
        fade-in-step = 0.05;
        fade-out-step = 0.05;
        no-fading-opencluse = false;

        fade-exclude = [];

        # vsync
        vsync = true; #TODO dont use with two monitors with different refresh rates

        # window rules
        rules = (
                { match = "name = 'Alacritty'"; opacity = 0.8; },
                { match = "name = 'rofi - dmenu'"; opacity = 0.8; },
                { match = "name = 'rofi - combi'"; opacity = 0.8; },
                { match = "class_i = 'spotify'"; opacity = 0.8; },
                { match = "role = 'xborder'"; blur-background = false; }, 
                { match = "class_i = 'i3-frame'"; corner-radius = 0; }, 
                )

        # corner
        corner-radius = 15; 
      '';
    };
  };

}
