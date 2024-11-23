{inputs, nixpkgs, nixpkgs-stable, home-manager, myvars, ...}:

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
  z790 = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable myvars;
      host = {
        hostname = "z790";
        # not sure I like to set it up like this
        mainMonitor = "HDMI-0";
        secondMonitor = "DP-5";
      };
    };
    modules = [
      ./z790
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # surface 
  surface = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable myvars;
      host = {
        hostname = "surface";
        #mainMonitor = "HDMI-0";
        #secondMonitor = "DP-5";
      };
    };
    modules = [
      ./surface
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # t480s
  t480s = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable myvars;
      host = {
        hostname = "t480s";
        #mainMonitor = "HDMI-0";
        #secondMonitor = "DP-5";
      };
    };
    modules = [
      ./t480s
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
  # pi4
}
