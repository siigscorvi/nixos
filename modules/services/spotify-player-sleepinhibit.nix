{ pkgs, vars, lib, config, ...}:
with lib;
let
  cfg = config.programs.spotify-cli;

  spotify-player-sleep-inhibit = pkgs.writeShellScriptBin "spotify-player-sleep-inhibit" ''
    LOCKPID=

    acquire() {
      systemd-inhibit --what=sleep --why="spotify-player is playing" sleep infinity &
      LOCKPID=$!
      ${pkgs.libnotify}/bin/notify-send "Spotify Player" "Inhibiting sleep while Spotify is playing"
    }

    release() {
      if [[ -n $LOCKPID ]] && kill -0 $LOCKPID 2>/dev/null; then
        kill "$LOCKPID"; wait "$LOCKPID" 2>/dev/null
      fi
      LOCKPID=
      ${pkgs.libnotify}/bin/notify-send "Spotify Player" "stopped inhibiting sleep because playback stopped"
    }

    prev=0
    while true; do
      status=$(${pkgs.playerctl}/bin/playerctl -p spotify_player status 2>/dev/null || echo "Stopped")
      if [[ $status == Playing && $prev != Playing ]]; then
        acquire
      elif [[ $status != Playing && $prev == Playing ]]; then
        release
      fi
      prev=$status
      sleep 60
    done
  '';
in {
  options.programs.spotify-cli = {
    sleep-inhibit = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the systemd user service to inhibit sleep while spotify-player is playing";
    };
  };

  config = mkIf cfg.autostart {
    assertions = [{
      assertion = !(!cfg.enable && cfg.sleep-inhibit);
      message = "cannot enable spotify-cli sleep-inhibit without enabling spotify cli";
    }];

    environment.systemPackages = [ spotify-player-sleep-inhibit ];

    systemd.user.services.spotify-player-sleep-inhibitor = {
      enable = true;
      description = "spotify-player sleep inhibitor";

      wants = [ "spotify-player.service" ];
      after = [ "spotify-player.service" ];
      partOf = [ "spotify-player.service" ];
      wantedBy = [ "spotify-player.service" ];

      serviceConfig = {
        ExecStart = "${spotify-player-sleep-inhibit}/bin/spotify-player-sleep-inhibit";
        Restart = "on-failure";
      };
    };
  };

}
