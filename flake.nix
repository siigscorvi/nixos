{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

# add nix user repository?

  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let 
      # system = "x86_64-linux"; TODO define system in the host

      vars = {
        user = "siigs";
        terminal = "alacritty";
        editor = "nvim";
      };


    in 
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager vars;
        }
      );

      homeConfigurations = (
        import ./nix{
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager vars;

        }
      );

#        siigs = lib.nixosSystem {
#          inherit system;
#          modules = [ 
#            ./configuration.nix 
#        
#            home-manager.nixosModules.home-manager {
#              home-manager.useGlobalPkgs = true;
#              home-manager.useUserPackages = true;
#              home-manager.users.siigs = {
#                imports = [ ./home.nix ];  
#              };
#            }
#
#          ];
#
#        };
#      };
    };
}
