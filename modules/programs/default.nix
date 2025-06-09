{
  imports = [
    ./nh.nix
    ./stylix.nix
    ./nextcloud.nix
    ./git.nix
    ./spotify.nix
    ./zsh.nix
    ./btop.nix
    ./tmux.nix
    ./thunderbird.nix
  ];

  environment.systemPackages = with pkgs; [
    drawio
    anki

    pandoc
    texlive.combined.scheme-full
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

    zathura
  ];
}
