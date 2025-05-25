{ inputs, nixpkgs, nixpkgs-stable, home-manager, vars, keys, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

in {
  genesis = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars keys;
      host = { hostname = "genesis"; };
    };

    modules = [
      ./genesis
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  moses = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars keys;
      host = { hostname = "moses"; };
    };

    modules = [
      ./moses
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # surface
  kain = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable vars keys;
      host = { hostname = "kain"; };
    };
    modules = [
      ./kain
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
