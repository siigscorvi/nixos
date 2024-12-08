{ vars, pkgs, ... }:

{
  home-manager.users.${vars.username} = {

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "${pkgs.btop}/share/btop/themes/gruvbox_dark.theme";
        theme_background = true;
        truecolor = true;
        vim_keys = true;
        update_ms = 1000;
        proc_sorting = "memory";
        proc_tree = true;
      };
    };

  };
}
