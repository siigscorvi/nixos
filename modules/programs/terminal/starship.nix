{ vars, ... }:

{
  home-manager.users.${vars.username} = {
    programs.starship.enable = true;

    home.file.".config/starship.toml" = {
      text = ''
        # Get editor completions based on the config schema
        "$schema" = 'https://starship.rs/config-schema.json'

        format = """
        $username\
        $hostname\
        $directory\
        $git_branch\
        $git_status\
        $git_metrics\
        $nix_shell\
        $python\
        $character
        """
        # has to be configured
        #  $c\
        #  $sudo\
        #  $cmake\
        #  $conda\
        #  $go\
        #  $rlang\
        #  $rust\
        #  $time\
        palette = 'gruvbox_dark'
        # Inserts a blank line between shell prompts
        add_newline = true

        [fill]
        symbol = ' '

        [palettes.gruvbox_dark]
        color_fg0 = '#fbf1c7'
        color_bg1 = '#3c3836'
        color_bg3 = '#665c54'
        color_blue = '#458588'
        color_aqua = '#689d6a'
        color_green = '#98971a'
        color_orange = '#d65d0e'
        color_purple = '#b16286'
        color_red = '#cc241d'
        color_red2 = '#fb4934'
        color_yellow = '#d79921'

        [username]
        # show_always = true
        style_root = 'bold color_red'
        style_user = 'bold color_yellow'
        format ='[$user]($style)'

        [hostname]
        ssh_only = true
        trim_at = '''
        style = 'bold color_blue'
        ssh_symbol = ' via  '
        format = '[@$hostname$ssh_symbol: ]($style)'

        [directory]
        fish_style_pwd_dir_length = 3
        truncation_length = 3
        style = 'bold color_aqua'
        read_only = ''
        read_only_style = 'bold color_red'
        format ='[$path]($style)[$read_only]($read_only_style)'

        [git_branch]
        symbol = ''
        style = 'bold color_purple'
        format = ' [$symbol \[$branch(:$remote_branch)]($style)'

        [git_status]
        style = 'bold color_purple'
        format = ' [$all_status$ahead_behind]($style)'

        [git_metrics]
        disabled = false
        added_style = 'bold color_green'
        deleted_style = 'bold color_red'
        format = ' [+$added]($added_style) [|](bold color_purple) [-$deleted]($deleted_style)[\]](bold color_purple)'

        [line_break]
        disabled = false

        # Replace the ''' symbol ➜
        [character] 
        success_symbol = '[ ❯](bold color_green)'
        error_symbol = '[ ❯](bold color_red)' 


        [os]
        disabled = false
        style = 'bold color_blue'

        [os.symbols]
        NixOS = ' '

        # [battery]
        # full_symbol = '🔋 '
        # charging_symbol = '⚡️ '

        # Disable the package module, hiding it from the prompt completely
        [package]
        disabled = true
      '';
    };

  };
}
