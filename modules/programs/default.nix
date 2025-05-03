{
  imports = [
    ./nh.nix
    ./nextcloud.nix
    ./git.nix
    ./spotify.nix
    ./zsh.nix
    ./btop.nix
    ./tmux.nix
    ./thunderbird.nix
    # moved to its own flake and added to hosts/configuration.ni
#    ./neovim.nix
    ./otherPrograms.nix
  ];
}
