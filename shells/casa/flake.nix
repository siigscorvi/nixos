{
  description = "flake for the dev shell, to be used for the casa class"; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let 
    pkgs = nixpkgs.legacyPackages."x84_64-linux";
  in
  {
    devShells."x84_64-linux".default =
      import ./shell.nix { inherit pkgs; };
  };
}
