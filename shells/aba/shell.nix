{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    gdb
    pwndbg
      
    ghidra

    jadx
    frida-tools
    android-tools
    jdk
    android-studio-tools
    androidStudioPackages.dev
    android-studio
    vscode

  ];
  shellHook = ''
    zsh
  '';
}
