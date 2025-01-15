{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gdb
    pwndbg
    ghidra
    jadx
  ];
  shellHook = ''
    zsh
    echo "casa shell"
  '';
}
