{ pkgs, vars, lib, config, ... }:

with lib;
let cfg = config.programs.zathura;
in {

  options.programs.zathura.enable = mkEnableOption "zathura pdf viewer";
  programs.zathura.enable = true;

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zathura ];

    home-manager.users.${vars.username} = {
      home.file.".config/zathura/zathurarc" = {
        text = "set selection-clipboard clipboard";
      };
    };

  };
}
