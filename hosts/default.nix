{inputs, nixpkgs, nixpkgs-stable, home-manager, vars, ...}:

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
  # main desktop profile
  base = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable vars;
      host = {
        hostname = "base";
        # not sure I like to set it up like this
        mainMonitor = "HDMI-0";
        secondMonitor = "DP-5";
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

  # surface laptop profile
  nomad = lib.nixosSystem {
    inherit sys_x86;
    specialArgs = {
      inherit inputs sys_x86 stable vars;
      host = {
        hostname = "nomad";
        #mainMonitor = "HDMI-0";
        #secondMonitor = "DP-5";
      };
    };
    modules = [
      ./nomad
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

}


