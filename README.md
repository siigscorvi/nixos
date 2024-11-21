# My Nixos Configuration

## file structure
```
.dotfiles/
|-- flake.nix
|-- flake.lock
|-- README.md
|-- hosts/
|   |-- z790/
|   |   |--- default.nix
|   |   |--- hardware-configuration.nix
|   |-- surface/
|   |   |--- default.nix
|   |   |--- hardware-configuration.nix
|   |-- t480s/
|   |   |--- default.nix
|   |   |--- hardware-configuration.nix
|-- desktop/
|   |-- default.nix
|   |-- i3.nix
|   |-- alacritty.nix
|   |-- thunar.nix
|   |-- rofi.nix
|   |-- picom.nix
|   |-- nvim.nix
|   |-- p7zip.nix
|   |-- xclip.nix
|   |-- btop.nix
|   |-- firefox.nix
|   |-- sound.nix
|   |-- git.nix
|   |-- wget.nix
|   |-- zsh.nix
|-- services/
|   |-- default.nix
|   |-- ssh.nix
|   |-- rdp.nix
|   |-- samba.nix
|   |-- otherfileshare.nix
|   |-- nh.nix
|   |-- vnc.nix
|-- config/
|   |-- i3config
|   |-- picom.conf
|   |-- polybar.ini
|   |-- starship.toml
|   |-- xborders.json
|   |-- nvim/...
|-- programs/
|   |-- spotify.nix
|   |-- vlc.nix
|   |-- discord.nix
|   |-- drawio.nix
|-- hardening/
|   |-- firejail.nix
|   |-- apparmor.nix
|-- vars/
|   |-- secrets.nix
|   |-- keys.nix
|   |-- theming.nix
```
