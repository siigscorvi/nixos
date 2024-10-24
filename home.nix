{ config, pkgs, ... }:

{

  home.username = "siigs";
  home.homeDirectory = "/home/siigs";
  home.shellAliases = {
    "g" = "git";
    "gst" = "git status";
    "gp" = "git push";
    "gc" = "git commit";
  };
  



  home.stateVersion = "24.05";

  programs = {
    home-manager.enable = true;
    git.enable = true;
    alacritty.enable = true;

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
   #offset = {
   #  x = -1;
   #  y = 0;
   #};
  };
}
