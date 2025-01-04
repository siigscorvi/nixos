{ pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    dex

    xborders
  ];

  home-manager.users.${vars.username} = {
    home.file.".config/xborders/config.json" = {
      text = ''
        {
         "border-rgba": "0xfbf1c7aa",
         "border-width": 2,
         "border-mode": "outside",
         "disable-version-warning": false,

         "positive-x-offset": 0,
         "positive-y-offset": 0,
         "negative-x-offset": 0,
         "negative-y-offset": 0
        }
      '';
    };

    home.file.".config/i3/config" = {
      text = ''
        # autostart 
        exec --no-startup-id dex --autostart --environment i3

        # screenlock timer
        exec_always --no-startup-id xset s 85 5
        exec_always --no-startup-id xss-lock -l -- xsecurelock

        # set wallpaper, start bar, picom and xborders
        exec_always --no-startup-id feh --bg-fill ~/.config/wallpapers/current
        exec_always --no-startup-id ~/.dotfiles/scripts/polybar.sh &
        # exec_always --no-startup-id ~/.dotfiles/scripts/dual.sh &
        exec_always --no-startup-id picom -b --log-file /tmp/picom.log --log-level "INFO" &
        exec --no-startup-id xborders -c ~/.config/xborders/config.json &

        ### Style configurations
        font pango:JetBrains\ Mono, FontAwesome 8

        default_orientation auto
        default_border none
        hide_edge_borders none
        gaps inner 3
        gaps outer 2
        # class                 border  backgr. text    indicator child_border
        client.focused          #F3F6FB #F3F6FB #00040D #AEFFFF   #F3F6FB
        client.focused_inactive #00040D #00040D #FFFFFF #00040D   #00040D
        client.unfocused        #00040D #00040D #FFFFFF #00040D   #00040D
        client.urgent           #900000 #900000 #FFFFFF #900000   #900000
        client.placeholder      #00040D #00040D #FFFFFF #00040D   #00040D
        client.background       #000000

        ### workspace settings 
        # workspace variables with displayed names 
        set $ws1 "1  "
        set $ws2 "2  "
        set $ws3 "3  "
        set $ws4 "4 󰝚 "
        set $ws5 "5   "
        set $ws6 "6   "
        set $ws7 "7  "
        set $ws8 "8  "
        set $ws9 "9  "
        set $ws10 "10"

        ## specific for dual monitor
        workspace $ws1 output $primary
        workspace $ws2 output $secondary
        workspace $ws3 output $secondary
        workspace $ws4 output $primary
        workspace $ws5 output $primary
        workspace $ws6 output $primary
        workspace $ws7 output $secondary
        workspace $ws8 output $secondary
        workspace $ws9 output $secondary
        workspace $ws10 output $primary

        ### input changes
        set $mod Mod4
        focus_follows_mouse no
        # multimedia volume controls
        bindsym XF86AudioMute exec amixer sset 'Master' toggle 
        bindsym XF86AudioLowerVolume exec amixer sset 'Master' 5%- 
        bindsym XF86AudioRaiseVolume exec amixer sset 'Master' 5%+

        bindsym XF86AudioPrev exec playerctl --player=spotify previous
        bindsym XF86AudioPlay exec playerctl --player=spotify play-pause
        bindsym XF86AudioNext exec playerctl --player=spotify next

        bindsym XF86MonBrightnessDown exec brillo -q -U 10
        bindsym XF86MonBrightnessUp exec brillo -q -A 10


        bindsym $mod+q kill
        # launch keybindings
        bindsym $mod+Return exec ${vars.terminal}
        bindsym $mod+d exec --no-startup-id "rofi -show combi -modes combi -combi-modes \\"window,ssh,drun,run\\""
        bindsym $mod+n exec firefox
        bindsym $mod+Control+n exec --no-startup-id spotify
        bindsym $mod+p exec --no-startup-id xsecurelock

        # open spotify on ws4 and firefox on ws2
        assign [class="^discord"] $ws8
        # spotify doesn't like assign keyword, spotify doesn't even like for_window keyword
        # this only works sometimes...
        for_window [class="potify"] move to workspace $ws4

        for_window [title="Bluetooth Devices"] floating enable
        for_window [title="Bluetooth Devices"] resize set 860 700

        for_window [title="Pipewire Volume Control"]  floating enable
        for_window [title="Pipewire Volume Control"] resize set 860 640 

        for_window [class="Thunar"] floating enable
        for_window [class="Thunar"] resize set 1080 640

        for_window [class=".arandr"] floating enable
        for_window [class=".arandr"] resize set 860 640 

        # vim keys
        bindsym $mod+h focus left
        bindsym $mod+j focus down
        bindsym $mod+k focus up
        bindsym $mod+l focus right
        bindsym $mod+Control+h move left
        bindsym $mod+Control+j move down
        bindsym $mod+Control+k move up
        bindsym $mod+Control+l move right

        # arrow keys
        bindsym $mod+Left resize shrink width 10 px or 10 ppt
        bindsym $mod+Down resize grow height 10 px or 10 ppt
        bindsym $mod+Up resize shrink height 10 px or 10 ppt
        bindsym $mod+Right resize grow width 10 px or 10 ppt

        # split in horizontal/vertical orientation
        bindsym $mod+b split h
        bindsym $mod+v split v

        # change container layout (fullscreen, stacked, tabbed, toggle split)
        bindsym $mod+f fullscreen toggle
        bindsym $mod+s layout stacking
        bindsym $mod+w layout tabbed
        bindsym $mod+e layout toggle split
        # flaoting, and dragging key
        bindsym $mod+Control+m floating toggle
        floating_modifier $mod

        # focus change
        bindsym $mod+a focus parent
        bindsym $mod+x focus child
        bindsym $mod+m focus mode_toggle

        # switch to workspace
        bindsym $mod+1 workspace number $ws1
        bindsym $mod+2 workspace number $ws2
        bindsym $mod+3 workspace number $ws3
        bindsym $mod+4 workspace number $ws4
        bindsym $mod+5 workspace number $ws5
        bindsym $mod+6 workspace number $ws6
        bindsym $mod+7 workspace number $ws7
        bindsym $mod+8 workspace number $ws8
        bindsym $mod+9 workspace number $ws9
        bindsym $mod+0 workspace number $ws10
        # workspace "back_and_forth". Pressing a $mod+num multiple times to switch back and forth
        workspace_auto_back_and_forth yes

        # move focused container to workspace
        bindsym $mod+Control+1 move container to workspace number $ws1
        bindsym $mod+Control+2 move container to workspace number $ws2
        bindsym $mod+Control+3 move container to workspace number $ws3
        bindsym $mod+Control+4 move container to workspace number $ws4
        bindsym $mod+Control+5 move container to workspace number $ws5
        bindsym $mod+Control+6 move container to workspace number $ws6
        bindsym $mod+Control+7 move container to workspace number $ws7
        bindsym $mod+Control+8 move container to workspace number $ws8
        bindsym $mod+Control+9 move container to workspace number $ws9
        bindsym $mod+Control+0 move container to workspace number $ws10

        # scratchpad
        bindsym $mod+t scratchpad show
        bindsym $mod+Control+t move scratchpad

        # move workspaces to different output
        # next allows me to cycle through outputs
        bindsym $mod+period move workspace to output next

        # reload the configuration file
        bindsym $mod+Control+c reload
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        bindsym $mod+Control+r restart
        # exit i3 (logs you out of your X session)
        bindsym $mod+Control+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
      '';
    };
  };

}
