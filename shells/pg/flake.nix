{
  description = "flake for the dev shell, to be used for the pg";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; config.segger-jlink.acceptLicense = true; };
    in
    {
      devShells."x86_64-linux".default = import ./shell.nix { inherit pkgs; };
    };
}
