{ pkgs, ... }:

{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    xfconf.enable = true;
  };

  services = {
    tumbler.enable = true;
    gvfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    file-roller
  ];
}
