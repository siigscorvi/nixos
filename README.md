# My Nixos Configuration
This README is TODO

## file structure
```
.dotfiles/
|-- flake.nix
|-- flake.lock
|-- README.md
|-- hosts/
|   |-- genesis/
|   |-- moses/
|-- modules/
|   |-- desktop/
|   |-- services/
|   |-- programs/
|   |-- hardening/
|   |-- vars/
|-- config/
|-- home/
|-- shells/
|-- scripts/
```

## roadmap wayland
| package                           | installed  | configured   |
| ---                               | ---        | ---          |
| greetd (displayManager)           | [x]        | [x]          |
| hyprland                          | [x]        | [x]          |
| rofi-hyprland                     | [x]        | [x]          |
| waybar                            | [x]        | [x]          |
| lockscreen                        | [x]        | [x]          |
| notification daemon               | [x]        | [ ]          |
| screenshot tool                   | [ ]        | [ ]          |
| wallpapers                        | [x]        | [x]          |
| touchpad gestures                 | [x]        | [x]          |

- [x] auto screen lock, blank, sleep (& hibernate)
- [x] tuigreet blocked by systemd messages
- [x] open and close lid
- [x] keep device from sleeping when music is playing with spotify-player
- [x] fingerprint login in lockscreen
- [x] clipboard

- [ ] consider hyprctl notification commands when configuring the notification daemon
- [ ] current music playback status in hyprlock

- [ ] rofi menu for scripts
    - [ ] script for eco mode https://wiki.hypr.land/Configuring/Uncommon-tips--tricks/#toggle-animationsbluretc-hotkey
    - [ ] rofi menu monitor configuration changes
    - [x] powermenu

- [ ] waybar focus indicator
- [ ] waybar hydration indicator
- [ ] waybar move indicator
- [ ] waybar indicator for current eco mode
- [ ] waybar music indicator (should be possible with playerctl metadata and dbus event?)
- [ ] on battery click open rofi eco script

- [ ] hyprsunset
- [ ] check what I need to change, since I use uwsm. Also Multi-GPU

- [ ] notification
    - [ ] when I pause and play music
    - [ ] when I change the volume
    - [ ] when I change brightness
    - [ ] when the battery is low
    - [ ] when battery is critical

- [ ] hibernate
- [ ] on startup open kitty with tmux resurrect open, after that SUPER+RETURN always open floating kitty

- [ ] wireguard interface script
https://github.com/HarHarLinks/wireguard-rofi-waybar



# Hardening
- [ ] hyprland permissions
- [ ] boot drive encryption
- [ ] hibernate to encrypted file
- [ ] apparmor
