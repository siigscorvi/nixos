{ pkgs, vars, ... }:

{
  home-manager.users.${vars.username} = {

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    programs.kitty.enable = true;
    programs.kitty = {

      themeFile = "GruvboxMaterialDarkMedium";
      shellIntegration.enableZshIntegration = true;

      font = {
        name = "JetBrainsMonoNerdFont";
        size = 12;
      };

      settings = {
        confirm_os_window_close = 0;
        enable_audio_bell = true;
        background_opacity = 0.8;
        mouse_hide_wait = "1.0";
      };

    };
  };

}
