{
  description = "flake for the dev shell, to be used for the casa class";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in
    {
      devShells."x86_64-linux".default = import ./shell.nix { inherit pkgs; };
    };
}
