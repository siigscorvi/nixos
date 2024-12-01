{inputs, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, vars, ...}:

let
  sys_x86 = "x86_64-linux";
  
  pkgs = import nixpkgs {
    inherit sys_x86;
    config.allowUnfree = true;
  };

  stable = import nixpkgs-stable {
    inherit sys_x86;
    config.allowUnfree = true;
  };
  
  lib = nixpkgs.lib;

in
{
  # z790 
  genesis = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable vars;
      host = {
        hostname = "genesis";
        # not sure I like to set it up like this
        mainMonitor = "DP-0";
        secondMonitor= "HDMI-0";
      };
    };
    modules = [
      ./genesis
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # t480s
  moses = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable vars;
      host = {
        hostname = "moses";
        mainMonitor = "eDP-0";
        secondMonitor = "HDMI-2";
      };
    };
    modules = [
      ./moses
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # surface
  kain = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable vars;
      host = {
        hostname = "kain";
        #mainMonitor = "HDMI-0";
        #secondMonitor = "DP-5";
      };
    };
    modules = [
      ./kain
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # pi4 - eden
  # router - zion
  # printer - mose, this ancient technology should have the name of an ancient writer
  # pve - noah
  # backup machine - lazarus
  # phone: gabriel - messenger and communication hub
}
