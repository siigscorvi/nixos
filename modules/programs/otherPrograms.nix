{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #drawio
    pandoc
    texlivePackages.collection-latexrecommended
    texliveTeTeX
    discord
    vlc
    firefox

    xournalpp
    openvpn
    openssl
    # this needs to move to a module!
    rofi
    arandr

    python313
  ];
}
