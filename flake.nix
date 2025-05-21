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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }:
    let
      vars = import ./modules/vars/var.nix;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit
            inputs
            nixpkgs
            nixpkgs-stable
            home-manager
            vars
            ;
        }
      );

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit
            inputs
            nixpkgs
            nixpkgs-stable
            home-manager
            vars
            ;

        }
      );
    };
}
