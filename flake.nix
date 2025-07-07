{
  description = "A very basic flake";

  # TODO: add nix user repository (nur)?
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

    hyprland.url = "github:hyprwm/hyprland?ref=v0.36.0";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-stable, home-manager
    , nixos-06cb-009a-fingerprint-sensor, rose-pine-hyprcursor, stylix, ... }:
    let
      vars = import ./modules/vars/var.nix;
      keys = import ./modules/vars/keys.nix;
    in {

      nixosConfigurations = (import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-stable home-manager vars keys
          nixos-06cb-009a-fingerprint-sensor rose-pine-hyprcursor stylix;
      });

      homeConfigurations = (import ./nix {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-stable home-manager vars keys stylix;
      });
    };
}
