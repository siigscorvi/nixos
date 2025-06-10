{ config, lib, ... }:
{
# What are the parts of a desktop?
# display manager
# display server
# window manager
# compositor
# lock screen
# information bar
  # applets
# notification daemon
# application launcher
# applications purely for theming / ricing
# applications for
  # display manipulation (order, lighting)
  # 

  imports = [
    ./thunar.nix
    ./soundgui.nix
    ./displayManager.nix
    ./xserver.nix # this should always be enabled
    ./alacritty.nix
    ./kitty.nix
    ./kdeconnect.nix
    ./stylix.nix
  ];
  # imports = [
  #   ./thunar.nix
  #   ./soundgui.nix
  #   ./ly.nix
  #   ./xserver.nix # this should always be enabled
  #   ./alacritty.nix
  #   ./kitty.nix
  #   ./kdeconnect.nix
  # ];
}
