{
  description = "A very basic flake";

  # TODO: add nix user repository?
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config.url = "github:siigscorvi/nvim";

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nixos-06cb-009a-fingerprint-sensor, stylix, ... }:
    let
      vars = import ./modules/vars/var.nix;
      keys = import ./modules/vars/keys.nix;
    in {

      nixosConfigurations = (import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-stable home-manager vars keys nixos-06cb-009a-fingerprint-sensor stylix;
      });

      homeConfigurations = (import ./nix {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-stable home-manager vars keys stylix;
      });
    };
}
