{ pkgs, vars, ... }: {
  environment.systemPackages = with pkgs; [ base16-schemes ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
  };

  home-manager.users.${vars.username} = {
    stylix.targets = {
      alacritty.enable = false;
      btop.enable = false;
      i3.enable = false;
      kitty.enable = false;
      lazygit.enable = false;
      kde.enable = false;
      neovim.enable = false;
      starship.enable = false;
      tmux.enable = false;
    };
  };
}

