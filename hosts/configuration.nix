{ lib, config, pkgs, stable, inputs, myvars, host, ... }:

# this let in might not be necessary if incorporated into desktop import
let
  terminal = pkgs.${myvars.terminal};
in 
{
  #imports zsh, ssh, users, git, btop
  imports = [
    ../services/ssh.nix
    ../programs/zsh.nix
    ../programs/nh.nix
    ../programs/tmux.nix
    ../programs/git.nix
    ../programs/btop.nix
  ];

  # default single user settings
  users.users.${myvars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
  };

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
    useXkbConfig = "de";
  };

  security = {
    rtkit.enable = true; # realtime scheduling permissions for user processes.
    polkit.enable = true; # since it might not be supplied by the DE I need a policy kit.
  };

  networking = {
    hostName = host.hostname;
    networkmanager.enable = true;
  };


  # default fonts on each system
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # default environment variables
  environment.variables = {
    TERMINAL = "${myvars.terminal}";
    EDITOR = "${myvars.editor}";
    VISUAL = "${myvars.editor}";
  };

  systemPackages = with pkgs; [
    coreutils # GNU core utilities.
    nano
    wget

    # hardware-near
    pciutils
    usbutils
    lshw # ls for hardware
    fastfetch

    # file management
    gvfs # gnome virtual filesystem
    file
    p7zip
    zip # not sure if I need both
    unzip
    unrar
    lf
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes"];
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

  system.stateVersion = "24.05";

  home-manager.users.${myvars.username} = {
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };

}
