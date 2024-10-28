{ config, pkgs, inputs, ... }:

{

  home.username = "siigs";
  home.homeDirectory = "/home/siigs";

  programs = {
    home-manager.enable = true;
    git.enable = true;
    alacritty.enable = true;
    lf.enable = true;
  };
  
  programs.git = {
    userEmail = "s76rhart@uni-bonn.de";
    userName = "siigscorvi";
    extraConfig = {
      color.ui = true;
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com:siigscorvi" = { 
          insteadOf = "https://github.com/siigscorvi";
        };
      };
    };
  };
  
  programs.alacritty.settings = {
    font = {
      normal.family = "JetBrainsMono Nerd Font Mono";
      bold = { style = "Bold"; };
      size = 11;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim



    ];
  };

  home.stateVersion = "24.05";
}
