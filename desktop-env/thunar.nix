{ pkgs, ... }:

{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
        thunar-share-plugin
      ];
    };
  };

  services = {
    tumbler.enable = true;
  };
}
