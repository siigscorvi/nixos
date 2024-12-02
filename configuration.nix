# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ ./hardware-configuration.nix
    ] ++ 
    (import ./desktop-env) ++
    (import ./services);

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 6;
    };
    timeout = 2;
  };  
  boot.loader.efi.canTouchEfiVariables = true;

  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  environment.pathsToLink = [ "/share/zsh" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input = {
      General = {
        UserspaceHID  = true;

      };
    };
  };

  services.blueman.enable = true;
    security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    });
  '';

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  networking = {
    hostName = "moses";
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  programs.nm-applet.enable = true;

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

  services.xserver = {
    enable = true;
    xkb.layout = "de";
    windowManager.i3.enable = true;
    displayManager = {
      lightdm.enable = true;
    };
  };
  services.displayManager = {
    defaultSession ="none+i3";
  };

  services.playerctld.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  programs.zsh.enable = true;

  users.users.siigs = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    p7zip
    unzip
    xclip
    fd
    fastfetch
    btop
    discord
    firefox
    git
    xorg.xbacklight
    file
    wget
    rofi
    arandr

    python313

    # audio stuff
    spotify
    alsa-utils
    qjackctl
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERM = "alacritty";
    TERMINAL = "alacritty";
    SHELL = "zsh";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

