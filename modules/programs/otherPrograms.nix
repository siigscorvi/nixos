{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    drawio
    pandoc
    texlivePackages.collection-latexrecommended
    texliveTeTeX
    discord
    vlc
    firefox

    # this needs to move to a module!
    rofi
    arandr

    nodejs_22
    python313
    go
    R
    
    spotify
  ];
}
