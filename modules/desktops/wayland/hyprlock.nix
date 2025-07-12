{ config, lib, pkgs, vars, ... }:
with lib;
let cfg = config.system.desktop.hyprlock;
in {
  options.system.desktop.hyprlock = {
    fingerprint = mkEnableOption "fingerprint authentication for hyprlock";

    background = {
      style = mkOption {
        type = types.str;
        default = "color";
        description =
          "Option for setting the background in hyprlock. Can be 'color', 'screenshot', or 'path'";
      };

      color = mkOption {
        type = types.str;
        default = "rgba(000000ff)";
        description =
          "Option for setting the background color in hyprlock. Can be named or rgba";
      };

      path = mkOption {
        type = types.str;
        default = "";
        description =
          "Option for setting the background color in hyprlock. Can be named or rgba";
      };
    };

  };

  config = {
    programs.hyprlock.enable = true;

    home-manager.users.${vars.username} = {
      home.file.".config/hypr/hyprlock.conf" = {
        force = true;
        text = ''
          $font = Monospace

          general {
              hide_cursor = false
              ignore_empty_input = true
              immediate_render = true
          }

          ${if !cfg.fingerprint then ""
          else ''
            auth {
                fingerprint {
                    enabled = true
                    # FIX: This does not work... Possibly unsupported?
                    ready_message = 󰈷󰄬
                    present_message = 󰈷󰍉
                    retry_delay = 250 # in milliseconds
                }
            }
          ''}

          animations {
              enabled = true
              bezier = linear, 1, 1, 0, 0
              animation = fadeIn, 0, 0, linear
              animation = fadeOut, 1, 5, linear
              animation = inputFieldDots, 1, 2, linear
          }

          background {
              monitor =
                ${if cfg.background.style == "color" then ''
                    color = ${cfg.background.color}
                  '' else "" }
                ${if cfg.background.style == "screenshot" then ''
                    path = screenshot
                    blur_passes = 4
                  '' else "" }
                ${if cfg.background.style == "path" then ''
                    path = ${cfg.background.path}
                  '' else "" }
                color = rgba(000000ff) # fallback color if something goes wrong
                }
          }

          input-field {
              monitor =
              size = 20%, 5%
              outline_thickness = 3
              inner_color = rgba(0, 0, 0, 0.0) # no fill

              outer_color = rgb(${config.theming.colors.rgb.accent})
              check_color = rgb(${config.theming.colors.rgb.bright-red}) rgb(${config.theming.colors.rgb.bright-green}) 120deg
              fail_color = rgb(${config.theming.colors.rgb.red}) rgb(${config.theming.colors.rgb.bright-red}) 40deg

              font_color = rgb(${config.theming.colors.rgb.fg})
              fade_on_empty = false
              rounding = 15

              font_family = $font
              ${if cfg.fingerprint then ''
              placeholder_text = 󰈷 or pw
                '' else ''
              placeholder_text = input pw
                ''}


              fail_text = $PAMFAIL

              # uncomment to use a letter instead of a dot to indicate the typed password
              # use zero-width whitespace to not show any characters on input
              dots_text_format = ​
              dots_size = 0.4
              dots_spacing = 0.3

              position = 0, -20
              halign = center
              valign = center
          }

          # TIME
          label {
              monitor =
              text = $TIME # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
              font_size = 40
              font_family = $font

              position = 0, 70
              halign = center
              valign = center
          }

        '';
      };
    };

  };

}

