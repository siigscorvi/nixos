{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polybar
    libmpdclient
    jsoncpp
    alsa-lib

    pwvucontrol
  ];
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };
}
