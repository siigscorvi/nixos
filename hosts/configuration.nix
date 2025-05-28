# This configuration is used in ALL systems!
{ pkgs, stable, inputs, vars, host, ... }:

# this let in might not be necessary if incorporated into desktop import
# TODO: If I move to have systems without a desktop environment, I should move this code as it would be unnecessary.
{
  imports = [ ../modules ];
  # TODO: after import ../modules activate my configuration of zsh, ssh, git, btop

  # default single user settings
  # TODO: this shoulld be host specific
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "docker"
      "camera"
      "plugdev"
      "networkmanager"
      "lp"
      "scanner"
    ];
  };

  # TODO: this shoulld be host specific
  programs.nix-ld.enable = true;
  virtualisation.docker.enable = true;

  # locale settings
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LANG = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # console settings
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # TODO: research if this is always needed
  security = {
    rtkit.enable = true; # realtime scheduling permissions for user processes.
    polkit.enable =
      true; # since it might not be supplied by the DE I need a policy kit.
  };

  networking = {
    hostName = host.hostname;
    networkmanager.enable = true;
  };

  # default fonts on each system
  fonts.packages = with pkgs; [ font-awesome nerd-fonts.jetbrains-mono ];

  # default environment variables
  # TODO: Maybe not every Host has a DE, so not all need TERMINAL and EDITOR
  environment.variables = {
    TERMINAL = "${vars.terminal}";
    EDITOR = "${vars.editor}";
    VISUAL = "${vars.editor}";
  };

  # TODO:move xdg-user-dirs to a program, along with its environment variables for config
  # TODO: find out if I need all: p7zip, zip, unzip, unrar...?
  environment.systemPackages = (with stable; [
    coreutils
    nano
    wget
    pciutils
    usbutils
    lshw
    fastfetch
    file
    p7zip
    zip
    unzip
    unrar
    lf
    fd
    xdg-user-dirs
    dysk
  ]) ++ (with pkgs; [ bat myNeovim ]);

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };

    registry.nixpkgs.flake = inputs.nixpkgs;
    #extraOptions = '' '';
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = inputs.nvim-config.overlays.default;

  system.stateVersion = "24.05";

  home-manager.users.${vars.username} = {
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
    home.homeDirectory = "/home/${vars.username}";
  };

}
