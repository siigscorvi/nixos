{ vars, ... }:
{
  programs.nh = {
    enable = true;
#    flake = "/home/${vars.username}/.dotfiles/";
  };
}
