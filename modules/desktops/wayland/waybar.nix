{ config, lib, vars, pkgs, ... }:
with lib;
let
  cfg = config.system.desktop.waybar;
  colors = config.theming.colors;
in {

  options.system.desktop.waybar = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hypridle for managing idle states in Hyprland";
    };
    battery = mkOption {
      type = types.bool;
      default = false;
      description = "Enable battery module in Waybar";
    };
    output = mkOption {
      type = types.str;
      default = "HDMI-1";
      description = "Choose the output on which waybar should run";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };

    home-manager.users.${vars.username} = {
      home.file.".config/waybar/config.jsonc" = {
        force = true;
        text = ''
          {
            "layer": "top",
            "output": "${cfg.output}",
            "position": "top",
            "height": 0,
            "spacing": 2,

            "margin-top": 4,
            "margin-right": 4,
            "margin-bottom": 0,
            "margin-left": 4,

            "mode": "dock",

            "modules-left": [
                "hyprland/workspaces",
                "tray"
            ],

            "modules-center": [
                "clock"
            ],

           "modules-right": [
                ${
                  if !cfg.battery then ''
                    "idle_inhibitor",
                    "pulseaudio"
                  '' else ''
                    "idle_inhibitor",
                    "pulseaudio",
                    "battery#power",
                    "battery#charge"
                  ''
                }
            ],

            ${
              if !cfg.battery then
                ""
              else ''
                "battery#power": {
                    "format-discharging": "{power:0.1f}W",
                    "format": "",
                    "interval": 20,
                    "tooltip": false
                },

                "battery#charge": {
                    "format": "{capacity}%",
                    "format-charging": "󱐋 {capacity}%",
                    "interval": 20,
                    "states": {
                        "full": 100,
                        "ninetyfive": 95,
                        "ninety": 90,
                        "eightyfive": 85,
                        "eighty": 80,
                        "seventyfive": 75,
                        "seventy": 70,
                        "sixtyfive": 65,
                        "sixty": 60,
                        "fiftyfive": 55,
                        "fifty": 50,
                        "fortyfive": 45,
                        "forty": 40,
                        "thirtyfive": 35,
                        "thirty": 30,
                        "twentyfive": 25,
                        "twenty": 20,
                        "fifteen": 15,
                        "ten": 10,
                        "five": 5
                    },
                    "on-click": "${pkgs.libnotify}/bin/notify-send HELP \" please implement the rofi script\"",
                    "tooltip": false
                },
              ''
            }

            "clock": {
              "interval": 60,
              "format": "{:%H:%M}",
              "tooltip": true,
              "tooltip-format": "<tt><big>{calendar}</big></tt>",
              "calendar": {
                "mode"          : "year",
                "mode-mon-col"  : 4,
                "weeks-pos"     : "right",
                "on-scroll"     : 1,
                "format": {
                  "months":     "<span color='${config.theming.colors.fg}'><b>{}</b></span>",
                  "days":       "<span color='${config.theming.colors.purple}'><b>{}</b></span>",
                  "weeks":      "<span color='${config.theming.colors.aqua}'><b>W{}</b></span>",
                  "weekdays":   "<span color='${config.theming.colors.yellow}'><b>{}</b></span>",
                  "today":      "<span color='${config.theming.colors.red}'><b><u>{}</u></b></span>"
                  }
                }
            },

            "hyprland/workspaces": {
              "format": "{icon}{name} ",
              "format-icons": {
                "active": " ",
                "default": " "
              },
              "disable-scroll": true,
              "all-outputs": true,
              "tooltip": false
            },

            "idle_inhibitor": {
              "format": "{icon}",
              "format-icons": {
                  "activated": "",
                  "deactivated": ""
              }
            },

            "pulseaudio": {
              "format": "{icon} {volume}%",
              "format-muted": "",
              "format-icons": {
                "headphone": "",
                "hdmi": " ",
                "bluetooth": "",
                "default": ["", ""]
              },
              "scroll-step": 5,
              "tooltip": true,
              "max-volume": 100,
              "on-click": "${pkgs.pwvucontrol}/bin/pwvucontrol",
              "on-click-right": "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            },

            "tray": {
                "spacing": 10,
                "icon-size": 14,
                "tooltip": true
            }
          }
        '';
      };
      home.file.".config/waybar/style.css" = {
        force = true;
        text = ''
          @define-color bg rgba(${colors.rgb.bg0_h}, 0.8);
          @define-color bg-empty rgba(${colors.rgb.bg2}, 0.8);
          @define-color bg-warning rgba(${colors.rgb.yellow}, 0.8);
          @define-color bg-critical rgba(${colors.rgb.red}, 0.8);
          @define-color bg-charging rgba(${colors.rgb.green}, 0.8);
          @define-color fg ${colors.fg};

          * {
              border: none;
              border-radius: 0;
              min-height: 0;
              font-family: "${config.theming.font}", monospace;
              font-weight: 900;
              font-size: 12px;
              padding: 0;
          }

          window#waybar {
              background: rgba(0, 0, 0, 0);
              border-radius: 28px;
          }

          tooltip {
              border-radius: 28px;

              color: @fg;
              background-color: @bg;
          }

          #battery,
          #clock,
          #workspaces,
          #idle_inhibitor,
          #tray,
          #tray menu,
          #pulseaudio {
              border-radius: 28px;
              padding-right: 12px;
              padding-left: 12px;
              padding-top: 4px;
              padding-bottom: 4px;

              color: @fg;
              background-color: @bg;
          }

          #workspaces {
            padding-left: 16px;
          }

          #workpaces.button.urgent {
            color: @bg-critical;
          }

          #pulseaudio {
              min-width: 50px;
          }

          #clock { }
          ${if !cfg.battery then
            ""
          else ''
            #battery { }
            #battery.power { }

            #battery.power.discharging {
                min-width: 45px;
            }

            #battery.charge {
                min-width: 45px;
            }

            #battery.charge.full {
              background: @bg;
            }
            #battery.charge.ninetyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 95%,
              @bg-empty 95%, @bg-empty 100%);
            }
            #battery.charge.ninety {
              background: linear-gradient(to right,
              @bg 0%, @bg 90%,
              @bg-empty 90%, @bg-empty 100%);
            }
            #battery.charge.eightyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 85%,
              @bg-empty 85%, @bg-empty 100%);
            }
            #battery.charge.eighty {
              background: linear-gradient(to right,
              @bg 0%, @bg 80%,
              @bg-empty 80%, @bg-empty 100%);
            }
            #battery.charge.seventyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 75%,
              @bg-empty 75%, @bg-empty 100%);
            }
            #battery.charge.seventy {
              background: linear-gradient(to right,
              @bg 0%, @bg 70%,
              @bg-empty 70%, @bg-empty 100%);
            }
            #battery.charge.sixtyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 65%,
              @bg-empty 65%, @bg-empty 100%);
            }
            #battery.charge.sixty {
              background: linear-gradient(to right,
              @bg 0%, @bg 60%,
              @bg-empty 60%, @bg-empty 100%);
            }
            #battery.charge.fiftyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 55%,
              @bg-empty 55%, @bg-empty 100%);
            }
            #battery.charge.fifty {
              background: linear-gradient(to right,
              @bg 0%, @bg 50%,
              @bg-empty 50%, @bg-empty 100%);
            }
            #battery.charge.fortyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 45%,
              @bg-empty 45%, @bg-empty 100%);
            }
            #battery.charge.forty {
              background: linear-gradient(to right,
              @bg 0%, @bg 40%,
              @bg-empty 40%, @bg-empty 100%);
            }
            #battery.charge.thirtyfive {
              background: linear-gradient(to right,
              @bg 0%, @bg 35%,
              @bg-empty 35%, @bg-empty 100%);
            }
            #battery.charge.thirty {
              background: linear-gradient(to right,
              @bg-warning 0%, @bg-warning 30%,
              @bg-empty 30%, @bg-empty 100%);
            }
            #battery.charge.twentyfive {
              background: linear-gradient(to right,
              @bg-warning 0%, @bg-warning 25%,
              @bg-empty 25%, @bg-empty 100%);
            }
            #battery.charge.twenty {
              background: linear-gradient(to right,
              @bg-warning 0%, @bg-warning 20%,
              @bg-empty 20%, @bg-empty 100%);
            }
            #battery.charge.fifteen {
              background: linear-gradient(to right,
              @bg-critical 0%, @bg-critical 15%,
              @bg-empty 15%, @bg-empty 100%);
            }
            #battery.charge.ten {
              background: linear-gradient(to right,
              @bg-critical 0%, @bg-critical 10%,
              @bg-empty 10%, @bg-empty 100%);
            }
            #battery.charge.five {
              background: linear-gradient(to right,
              @bg-critical 0%, @bg-critical 5%,
              @bg-empty 5%, @bg-empty 100%);
            }


            #battery.charge.charging.ninetyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 95%,
              @bg-empty 95%, @bg-empty 100%);
            }
            #battery.charge.charging.ninety {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 90%,
              @bg-empty 90%, @bg-empty 100%);
            }
            #battery.charge.charging.eightyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 85%,
              @bg-empty 85%, @bg-empty 100%);
            }
            #battery.charge.charging.eighty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 80%,
              @bg-empty 80%, @bg-empty 100%);
            }
            #battery.charge.charging.seventyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 75%,
              @bg-empty 75%, @bg-empty 100%);
            }
            #battery.charge.charging.seventy {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 70%,
              @bg-empty 70%, @bg-empty 100%);
            }
            #battery.charge.charging.sixtyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 65%,
              @bg-empty 65%, @bg-empty 100%);
            }
            #battery.charge.charging.sixty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 60%,
              @bg-empty 60%, @bg-empty 100%);
            }
            #battery.charge.charging.fiftyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 55%,
              @bg-empty 55%, @bg-empty 100%);
            }
            #battery.charge.charging.fifty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 50%,
              @bg-empty 50%, @bg-empty 100%);
            }
            #battery.charge.charging.fortyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 45%,
              @bg-empty 45%, @bg-empty 100%);
            }
            #battery.charge.charging.forty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 40%,
              @bg-empty 40%, @bg-empty 100%);
            }
            #battery.charge.charging.thirtyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 35%,
              @bg-empty 35%, @bg-empty 100%);
            }
            #battery.charge.charging.thirty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 30%,
              @bg-empty 30%, @bg-empty 100%);
            }
            #battery.charge.charging.twentyfive {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 25%,
              @bg-empty 25%, @bg-empty 100%);
            }
            #battery.charge.charging.twenty {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 20%,
              @bg-empty 20%, @bg-empty 100%);
            }
            #battery.charge.charging.fifteen {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 15%,
              @bg-empty 15%, @bg-empty 100%);
            }
            #battery.charge.charging.ten {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 10%,
              @bg-empty 10%, @bg-empty 100%);
            }
            #battery.charge.charging.five {
              background: linear-gradient(to right,
              @bg-charging 0%, @bg-charging 5%,
              @bg-empty 5%, @bg-empty 100%);
            }
          ''}
        '';
      };
    };
  };
}

