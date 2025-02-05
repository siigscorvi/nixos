{ pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];


}
