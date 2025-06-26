{ config, lib, pkgs, ... }:
with lib; {
  # this is was is used in other modules
  options.theming = {
    colors = {

      bg = mkOption {
        type = types.str;
        default = "#282828";
      };
      fg = mkOption {
        type = types.str;
        default = "#ebdbb2";
      };

      red1 = mkOption {
        type = types.str;
        default = "#cc241d";
      };
      red2 = mkOption {
        type = types.str;
        default = "#fb4934";
      };
      green1 = mkOption {
        type = types.str;
        default = "#98971a";
      };
      green2 = mkOption {
        type = types.str;
        default = "#b8bb26";
      };
      yellow1 = mkOption {
        type = types.str;
        default = "#d79921";
      };
      yellow2 = mkOption {
        type = types.str;
        default = "#fabd2f";
      };
      blue1 = mkOption {
        type = types.str;
        default = "#458588";
      };
      blue2 = mkOption {
        type = types.str;
        default = "#84a598";
      };
      purple1 = mkOption {
        type = types.str;
        default = "#b16286";
      };
      purple2 = mkOption {
        type = types.str;
        default = "#d3869b";
      };
      aqua1 = mkOption {
        type = types.str;
        default = "#689d6a";
      };
      aqua2 = mkOption {
        type = types.str;
        default = "#8ec07c";
      };
      gray1 = mkOption {
        type = types.str;
        default = "#a89984";
      };
      gray2 = mkOption {
        type = types.str;
        default = "#928374";
      };
      orange = mkOption {
        type = types.str;
        default = "#d65d0e";
      };
      orange2 = mkOption {
        type = types.str;
        default = "#fe8019";
      };

      bg0_h = mkOption {
        type = types.str;
        default = "#1d2021";
      };
      bg0 = mkOption {
        type = types.str;
        default = "#282828";
      };
      bg1 = mkOption {
        type = types.str;
        default = "#3c3836";
      };
      bg2 = mkOption {
        type = types.str;
        default = "#504945";
      };
      bg3 = mkOption {
        type = types.str;
        default = "#665c54";
      };
      bg4 = mkOption {
        type = types.str;
        default = "#7c6f64";
      };

      bg0_s = mkOption {
        type = types.str;
        default = "#32302f";
      };
      fg0 = mkOption {
        type = types.str;
        default = "#fbf1c7";
      };
      fg1 = mkOption {
        type = types.str;
        default = "#ebdbb2";
      };
      fg2 = mkOption {
        type = types.str;
        default = "#d5c4a1";
      };
      fg3 = mkOption {
        type = types.str;
        default = "#bdae93";
      };
      fg4 = mkOption {
        type = types.str;
        default = "#a89984";
      };
    };
    font = mkOption {
      type = types.str;
      default = "JetBrains Mono Nerd Font";
    };

  };
}
