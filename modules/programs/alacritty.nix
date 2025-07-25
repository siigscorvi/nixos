{ vars, ... }:

{
  home-manager.users.${vars.username} = {
    programs.alacritty.enable = true;
    programs.alacritty.settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font Mono";
        bold = {
          style = "Bold";
        };
        size = 11;
      };
      general = {
        import = [ "~/.config/alacritty/gruvboxDark.toml" ];
      };
    };

    # this is not mine and stolen from https://github.com/alacritty/alacritty-theme
    home.file.".config/alacritty/gruvboxDark.toml" = {
      text = ''
        # Colors (Gruvbox dark)

        # Default colors
        [colors.primary]
        # hard contrast background = = '#1d2021'
        background = '#282828'
        # soft contrast background = = '#32302f'
        foreground = '#ebdbb2'

        # Normal colors
        [colors.normal]
        black   = '#282828'
        red     = '#cc241d'
        green   = '#98971a'
        yellow  = '#d79921'
        blue    = '#458588'
        magenta = '#b16286'
        cyan    = '#689d6a'
        white   = '#a89984'

        # Bright colors
        [colors.bright]
        black   = '#928374'
        red     = '#fb4934'
        green   = '#b8bb26'
        yellow  = '#fabd2f'
        blue    = '#83a598'
        magenta = '#d3869b'
        cyan    = '#8ec07c'
        white   = '#ebdbb2'
      '';
    };

  };
}
