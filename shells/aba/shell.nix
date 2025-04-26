{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gdb
    pwndbg
      
    ghidra
  ];
  shellHook = ''
    zsh
  '';
}
