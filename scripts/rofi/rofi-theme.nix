{ pkgs, vars, lib, config, ... }: {
  home-manager.users.${vars.username} = {
    home.file.".config/rofi/colors.rasi" = {
      text = ''
        * {
          background:     ${config.theming.colors.bg0_h};
          background-alt: ${config.theming.colors.bg2};
          foreground:     ${config.theming.colors.fg};
          selected:       ${config.theming.colors.yellow1};
          active:         ${config.theming.colors.green1};
          urgent:         ${config.theming.colors.red1};
        }
      '';
    };

    home.file.".config/rofi/font.rasi" = {
      text = ''
        * {
          font: "${config.theming.font} 10";
        }
      '';
    };
  };
}

