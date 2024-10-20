{config, pkgs, home-manager, ... }

{

  services.xserver.windowManager.i3.configFile = $HOME/.dotfiles/i3/config;

}
