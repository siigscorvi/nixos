{ config, lib, vars, pkgs, inputs, ... }:
with lib;
let
  cfg = config.system.desktop.hyprland;
  colors = config.theming.colors;
  terminal-pkg = "${pkgs.kitty}/bin/kitty";
  menu =
    "${pkgs.rofi-wayland}/bin/rofi -combi-modi window,drun,run,ssh -show combi";
in {
  imports = [ ./hypridle.nix ./waybar.nix ./hyprlock.nix ];

  options.system.desktop.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hyprland as the Wayland compositor";
    };

    monitors = mkOption {
      type = types.str;
      default = ''
        monitor=,preferred,auto-up,1
      '';
      description = "Hyprland monitor configuration";
    };
    workspace-rules = mkOption {
      type = types.str;
      default = "";
      description = "Hyprland workspace monitor configuration";
    };

    inactive-transparency = mkOption {
      type = types.float;
      default = 1.0;
      description = "Inactive window transparency value";
    };

    shadow = mkEnableOption "shadows on windows";
    blur = mkEnableOption "blur on transparent windows";
    animations = mkEnableOption "animations";
    swapcaps = mkEnableOption "swapping escape and capslock";
  };

  config = mkIf cfg.enable {

    programs.uwsm.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    environment.systemPackages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      hyprpaper
      hyprpolkitagent
      rofi-wayland
      wl-clipboard-rs
    ];

    home-manager.users.${vars.username} = {

      home.file.".config/hypr/hyprpaper.conf" = {
        force = true;
        text = ''
          preload = /home/siigs/.config/wallpapers/current
          wallpaper = , /home/siigs/.config/wallpapers/current
        '';
      };

      home.file.".config/hypr/monitor.conf" = {
        text = ''
          ${cfg.monitors}
          ${cfg.workspace-rules}
        '';
      };

      home.file.".config/hypr/hyprland.conf" = {
        text = ''
          source = ~/.config/hypr/monitor.conf
          source = ~/.config/hypr/test.conf

          # startup commands
          exec-once = [workspace 1] ${terminal-pkg}
          exec-once = [workspace special:magic silent] ${terminal-pkg}
          ## services
          exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
          exec-once = ${pkgs.systemd}/bin/systemctl --user start hyprpolkitagent

          exec-once = ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator
          exec-once = ${pkgs.bitwarden-desktop}/bin/bitwarden

          # environment variables
          env = XCURSOR_SIZE,32
          env = HYPRCURSOR_THEME,rose-pine-hyprcursor
          env = HYPRCURSOR_SIZE,32

          # permissions

          # See https://wiki.hyprland.org/Configuring/Permissions/
          # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
          # for security reasons

          # ecosystem {
          #   enforce_permissions = 1
          # }

          # permission = /usr/(bin|local/bin)/grim, screencopy, allow
          # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
          # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow

          # look and feel

          general {
              gaps_in = 1
              gaps_out = 2

              border_size = 2

              # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
              col.active_border = rgba(${
                lib.strings.removePrefix "#" colors.accent
              }ee)
              col.inactive_border = rgba(${
                lib.strings.removePrefix "#" colors.bg2
              }ee)

              resize_on_border = false

              allow_tearing = false

              layout = dwindle
          }

          xwayland {
            force_zero_scaling = true
          }

          decoration {
              rounding = 10
              rounding_power = 2

              # Change transparency of focused and unfocused windows
              active_opacity = 1.0
              inactive_opacity = ${toString cfg.inactive-transparency}

              shadow {
                ${
                  if cfg.shadow then ''
                    enabled = true
                  '' else ''
                    enabled = false
                  ''
                }
                  range = 4
                  render_power = 3
                  color = rgba(1a1a1aee)
              }

              # https://wiki.hyprland.org/Configuring/Variables/#blur
              blur {
              ${
                if cfg.blur then ''
                  enabled = true
                '' else ''
                  enabled = false
                ''
              }
                  size = 5
                  passes = 2

                  new_optimizations = true
                  xray = true

                  vibrancy = 0.1696
              }
          }

          animations {
          ${if cfg.animations then ''
            enabled = true
          '' else ''
            enabled = false
          ''}

              # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = easeOutQuint,0.23,1,0.32,1
              bezier = easeInOutCubic,0.65,0.05,0.36,1
              bezier = linear,0,0,1,1
              bezier = almostLinear,0.5,0.5,0.75,1.0
              bezier = quick,0.15,0,0.1,1

              animation = global, 1, 10, default
              animation = border, 1, 5.39, easeOutQuint
              animation = windows, 1, 4.79, easeOutQuint
              animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
              animation = windowsOut, 1, 1.49, linear, popin 87%
              animation = fadeIn, 1, 1.73, almostLinear
              animation = fadeOut, 1, 1.46, almostLinear
              animation = fade, 1, 3.03, quick
              animation = layers, 1, 3.81, easeOutQuint
              animation = layersIn, 1, 4, easeOutQuint, fade
              animation = layersOut, 1, 1.5, linear, fade
              animation = fadeLayersIn, 1, 1.79, almostLinear
              animation = fadeLayersOut, 1, 1.39, almostLinear
              animation = workspaces, 1, 1.94, almostLinear, fade
              animation = workspacesIn, 1, 1.21, almostLinear, fade
              animation = workspacesOut, 1, 1.94, almostLinear, fade
          }

          dwindle {
              pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # You probably want this
          }

          master {
              new_status = master
          }

          misc {
              force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
              disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
              background_color = rgba(${
                lib.strings.removePrefix "#" colors.bg
              }ee)
          }

          # input

          input {
              kb_layout = de
              ${
                if cfg.swapcaps then ''
                  kb_options = caps:swapescape
                '' else
                  ""
              }

              follow_mouse = 2

              sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.

              touchpad {
                  natural_scroll = true
              }
          }
          # glove80 never needs swapcaps
          device {
            name = moergo-glove80-left-keyboard
            kb_options = caps
          }


          gestures {
              workspace_swipe = true
          }

          # keybinds
          binds {
            allow_workspace_cycles = true
            workspace_back_and_forth = true
          }

          $mainMod = SUPER

          # executing binds
          bind = $mainMod, RETURN, exec, ${terminal-pkg}
          bind = $mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar
          bind = $mainMod, D, exec, ${pkgs.toybox}/bin/pgrep rofi && ${pkgs.toybox}/bin/pkill rofi || ${menu}
          bind = $mainMod CTRL, R, exec, hypr-reload
          bind = $mainMod, P, exec, ${pkgs.hyprlock}/bin/hyprlock

          bind = $mainMod, N, exec, ${pkgs.firefox}/bin/firefox

          # window manipulation binds
          bind = $mainMod, H, movefocus, l
          bind = $mainMod, J, movefocus, d
          bind = $mainMod, K, movefocus, u
          bind = $mainMod, L, movefocus, r

          bind = $mainMod CTRL, H, movewindow, l
          bind = $mainMod CTRL, J, movewindow, d
          bind = $mainMod CTRL, K, movewindow, u
          bind = $mainMod CTRL, L, movewindow, r

          binde = $mainMod, right, resizeactive, 10 0
          binde = $mainMod, left, resizeactive, -10 0
          binde = $mainMod, up, resizeactive, 0 -10
          binde = $mainMod, down, resizeactive, 0 10


          bind = $mainMod, M, togglefloating,
          bind = $mainMod, Q, killactive,
          bind = $mainMod, F, fullscreen,

          # workspace manipulation binds
          bind = $mainMod, code:60, movecurrentworkspacetomonitor, -1

          bind = $mainMod SHIFT, H, movecurrentworkspacetomonitor, l
          bind = $mainMod SHIFT, J, movecurrentworkspacetomonitor, d
          bind = $mainMod SHIFT, K, movecurrentworkspacetomonitor, u
          bind = $mainMod SHIFT, L, movecurrentworkspacetomonitor, r

          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          bind = $mainMod CTRL, 1, movetoworkspace, 1
          bind = $mainMod CTRL, 2, movetoworkspace, 2
          bind = $mainMod CTRL, 3, movetoworkspace, 3
          bind = $mainMod CTRL, 4, movetoworkspace, 4
          bind = $mainMod CTRL, 5, movetoworkspace, 5
          bind = $mainMod CTRL, 6, movetoworkspace, 6
          bind = $mainMod CTRL, 7, movetoworkspace, 7
          bind = $mainMod CTRL, 8, movetoworkspace, 8
          bind = $mainMod CTRL, 9, movetoworkspace, 9
          bind = $mainMod CTRL, 0, movetoworkspace, 10

          bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
          bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
          bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
          bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
          bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
          bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
          bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
          bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
          bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
          bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

          # magic workspace
          bind = $mainMod, T, togglespecialworkspace, magic
          bind = $mainMod CTRL, T, movetoworkspace, special:magic

          # Scroll through workspaces
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mouse
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
          bindm = SUPER, SPACE, movewindow
          bindm = SUPER, ALT_L, resizewindow

          # speical keys
          bindel = ,XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
          bindel = ,XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindel = ,XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bindel = ,XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

          bindel = ,XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -qA 5 && notify-send -r 4444 "Brightness increased" "$(brillo)"
          bindel = ,XF86MonBrightnessDown, exec, ${pkgs.brillo}/bin/brillo -qU 5 && notify-send -r 4444 "Brightness decreased" "$(brillo)"

          bindl = , XF86AudioNext, exec, ${pkgs.spotify-player}/bin/spotify_player playback next
          bindl = , XF86AudioPlay, exec, ${pkgs.libnotify}/bin/notify-send "spotify-player" "playback play-paused" && spotify_player playback play-pause
          bindl = , XF86AudioPrev, exec, ${pkgs.spotify-player}/bin/spotify_player playback previous

          bindl = $mainMod, code:118, exec, ${pkgs.spotify-player}/bin/spotify_player playback next # Pos1
          bindl = $mainMod, code:115, exec, ${pkgs.libnotify}/bin/notify-send "spotify-player" "playback play-paused" && spotify_player playback play-pause # Ende
          bindl = $mainMod, code:110, exec, ${pkgs.spotify-player}/bin/spotify_player playback previous # Einf

          # bind = ,XF86Display, exec, # switch display configuration
          # bind = ,XF86WLAN, exec, # switch wireless lan on and off / switch vpn on and off?
          bind = ,XF86Tools, exec, ${pkgs.toybox}/bin/pgrep rofi && ${pkgs.toybox}/bin/pkill rofi || rofi-hypr-powermenu
          # bind = ,XF86Bluetooth, exec, # switch bluetooth on and of
          # bind = ,XF86Favorites, exec, # Lock screen? Special rofi menu?

          bindl = , switch:on:Lid Switch, exec, ${pkgs.systemd}/bin/systemctl suspend

          # window rules
          ## thunar file browser
          windowrule = float, class:^(thunar)$
          windowrule = float, class:^(Thunar)$
          windowrule = size 70% 70%, class:^(thunar)$
          windowrule = size 70% 70%, class:^(Thunar)$

          ## discord
          windowrule = workspace 8, class:^(discord)$
          windowrule = noinitialfocus, class:^(discord)$

          ## kitty
          windowrule = float, class:^(kitty)$
          windowrule = size 70% 70%, class:^(kitty)$

          ## rofi
          windowrule = stayfocused, class:^(Rofi)$

          ## thunderbrid
          windowrule = workspace 9, initialClass:^(thunderbird)$, initialTitle:^(Mozilla Thunderbird)$
          windowrule = noinitialfocus, initialClass:^(thunderbird)$, initialTitle:^(Mozilla Thunderbird)$

          windowrule = workspace 1, initialClass:^(thunderbird)$, initialTitle:^(Calendar Reminders)$
          windowrule = float, initialClass:^(thunderbird)$, initialTitle:^(Calendar Reminders)$
          windowrule = move 69.5% 3%, initialClass:^(thunderbird)$, initialTitle:^(Calendar Reminders)$
          windowrule = size 30% 40%, initialClass:^(thunderbird)$, initialTitle:^(Calendar Reminders)$
          windowrule = noinitialfocus, initialClass:^(thunderbird)$, initialTitle:^(Calendar Reminders)$

          windowrule = float, initialClass:^(thunderbird)$, initialTitle:^()$
          windowrule = size 30% 40%, initialClass:^(thunderbird)$, initialTitle:^()$

          windowrule = float, initialClass:^(thunderbird)$, initialTitle:^(Edit Item)$
          windowrule = size 30% 40%, initialClass:^(thunderbird)$, initialTitle:^(Edit Item)$

          ## sound control
          windowrule = float, class:^(com.saivert.pwvucontrol)$, title:^(Pipewire Volume Control)$
          windowrule = size 40% 40%, class:^(com.saivert.pwvucontrol)$, title:^(Pipewire Volume Control)$

          ## bluetooth manager
          windowrule = float, class:^(.blueman-manager-wrapped)$
          windowrule = size 30% 80%, class:^(.blueman-manager-wrapped)$

          ## network mananger
          windowrule = float, class:^(nm-connection-editor)$, title:^(Network Connections)$
          windowrule = size 40% 80%, , class:^(nm-connection-editor)$, title:^(Network Connections)$

          windowrule = float, class:^(nm-connection-editor)$, title:^(Editing).*
          windowrule = size 20% 40%, , class:^(nm-connection-editor)$, title:^(Editing).*

          # Ignore maximize requests from apps. You'll probably like this.
          windowrule = suppressevent maximize, class:.*

          # Fix some dragging issues with XWayland
          windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        '';
      };

    };

  };
}
