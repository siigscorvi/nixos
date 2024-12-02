{ pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    polybar
    libmpdclient
    jsoncpp
    alsa-lib

    pwvucontrol
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };
  home-manager.users.${vars.username} = {
    home.file.".config/polybar/config.ini" = {
      text = ''
        [bar/primary]
        # monitor setting might need to be changed for laptop
        inherit = default
        modules-left = date
        modules-center = i3
        modules-right = tray battery alsa ethernet wireless powermenu
        # filesystem cpu memory 

        [settings]
        pseudo-transparency = true
        screenchange-reload = true

        [default]
        bottom = false
        font-0 = "JetBrains Mono Nerd Font:size=9;2"
        enable-ipc = true
        background = ''${colors.bg0_h}
        foreground = ''${colors.fg0}
        border-size = 0
        padding = 1
        height = 15

        [module/date]
        type = internal/date
        format = <label>
        label = %time% %date%
        date = %a %d.%b.%Y%
        time = %H:%M:%S

        #[module/filesystem]
        #type = internal/fs
        #interval = 300
        #mount-0 = /
        #mount-1 = /ssd
        #fixed-values = false
        #format-mounted = <label-mounted>
        #label-mounted = %mountpoint%: %free%
        #[module/cpu]
        #type = internal/cpu
        #interval = 5
        #label = "  %percentage%%"
        #label-minlen = 7
        #
        #warn-percentage = 90
        #label-warn = "  %percentage%"
        #label-warn-foreground = ''${colors.red}
        #label-warn-minlen = 7
        #
        #format = <label>
        #format-warn = <label-warn>
        #[module/memory]
        #type = internal/memory
        #interval = 5
        #label = "  %gb_used%"
        #label-minlen = 12
        #warn-percentage = 90
        #label-warn = "  %gb_used%"
        #label-warn-foreground = ''${colors.red}
        #label-warn-minlen = 12
        #
        #format = <label>
        #format-warn = <label-warn>


        [module/tray]
        type = internal/tray
        tray-padding = 3
        tray-spazing = 3
        tray-size = 80

        [module/powermenu]
        type = custom/text
        format = "  "
        click-left = exec ~/.dotfiles/scripts/rofi_powermenu.sh &

        [module/ethernet]
        type = internal/network
        interface-type = wired
        interval = 5

        label-connected = "󰈁 "
        format-connected = <label-connected>

        label-disconnected = "󰈂 "
        format-disconnected = <label-disconnected>

        [module/wireless]
        type = internal/network
        interface-type = wireless
        interval = 5

        label-connected = "%essid%"
        format-connected = <ramp-signal><label-connected> 

        ramp-signal-0 = "󰤟 "
        ramp-signal-1 = "󰤢 "
        ramp-signal-2 = "󰤥 "
        ramp-signal-3 = "󰤨 "


        label-disconnected = "󰤭 "
        format-disconnected = <label-disconnected>

        [module/battery]
        # only applied if the battery is found
        type = internal/battery
        full-at = 100
        battery = BAT0
        adapter = ACAD

        format-charging = <animation-charging><label-charging>
        format-charging-padding = 1
        #format-charging-foreground = ''${colors.green}

        format-discharging = "<ramp-capacity><label-discharging> "
        format-full-padding = 1
        format-full-foreground = ''${colors.green}

        label-charging = "%percentage:2%%  "
        label-discharging = %percentage:2%%
        label-full = "󰁹 %percentage: 2%%  "

        ramp-capacity-0 = "󰂎 "
        ramp-capacity-1 = "󰁼 "
        ramp-capacity-2 = "󰁾 "
        ramp-capacity-3 = "󰂀 " 
        ramp-capacity-4 = "󰁹 "

        animation-charging-0 = "󰂎 "
        animation-charging-1 = "󰁼 "
        animation-charging-2 = "󰁾 "
        animation-charging-3 = "󰂀 "
        animation-charging-4 = "󰁹 "

        [module/alsa]
        # TODO 󰟳 make it show if my surround sound is on.
        # TODO my way of making it the same size seems not right
        type = internal/alsa

        #format-volume-background = ''${colors.bg0}
        #label-volume-minlen = 4
        ramp-volume-0 = "󰖀 "
        ramp-volume-1 = "󰕾 "
        format-volume = "<ramp-volume><label-volume> "

        #format-muted-background = ''${colors.bg0}
        #label-muted-minlen = 6
        label-muted = "󰖁 " 
        format-muted = "<label-muted>"

        click-middle = qjackctl
        click-right = pwvucontrol


        [module/i3]
        type = internal/i3
        show-urgent = true
        index-sort = true
        enable-click = true
        enable-scroll = true
        format = <label-state> <label-mode>

        label-mode = %mode%
        label-mode-padding = 3
        label-mode-background = ''${colors.bg0}

        label-focused = %name%
        label-focused-foreground = ''${colors.fg0}
        label-focused-padding = 3

        label-unfocused = %name%
        label-unfocused-foreground = ''${colors.bg2}
        label-unfocused-padding = 3

        label-visible = %name%
        label-visible-foreground = ''${colors.fg3}
        label-visible-padding = 3

        label-urgent = %name%
        label-urgent-foreground = ''${colors.red}
        label-urgent-padding = 3

        [colors]
        fg0 = #fbf1c7
        fg2 = #d5c4a1
        fg3 = #bdae93
        fg4 = #a89984
        bg0_h = #001d2021
        bg0 = #282828
        bg1 = #3c3836
        bg2 = #504945
        bg3 = #665c54
        blue = #458588
        aqua = #689d6a
        green = #98971a
        orange = #d65d0e
        purple = #b16286
        red = #cc241d
        red2 = #fb4934
        yellow = #d79921

      '';
    };
  };
}
