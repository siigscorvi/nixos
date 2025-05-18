{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gdb
    pwndbg

    ghidra
    (python3.withPackages(p: with p; [
      pwntools
    ]))
  ];
  shellHook = ''
    zsh
  '';
}
