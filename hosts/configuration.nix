{ lib, config, pkgs, stable, inputs, myvars, ... }:

let
  terminal = pkgs.${myvars.terminal};
in 
{
  #imports 

  # default single user settings
  users.users.${myvars.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
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

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = "de";
  };

  security = {
    rtkit.enable = true; # realtime scheduling permissions for user processes.
    polkit.enable = true; # since it might not be supplied by the DE I need a policy kit.
  };

  fonts.packages = with pkgs; [
    font-awesome
    vegur
    carlito
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.variables = {
    TERMINAL = "${myvars.terminal}";
    EDITOR = "${myvars.editor}";
    VISUAL = "${myvars.editor}";
  };

#TODO this should be a module that is always imported
  programs.zsh.enable = true;

#TODO this should be a module that is always imported
  services.ssh = {
    enable = true;
    # allowSFTP = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${myvars.username}" ]; 
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; 
    };
  };

  systemPackages = with pkgs; [
    coreutils # GNU core utilities.
    git
    btop # better top alternative.
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



  


}
