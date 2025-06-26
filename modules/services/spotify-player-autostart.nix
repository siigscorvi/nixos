{ pkgs, vars, lib, config, ...}:
with lib;
let
  cfg = config.programs.spotify-cli;
in {
  options.programs.spotify-cli = {
    autostart = mkOption {
      type = types.bool;
      default = true;
      description = "Enable autostart on boot of spotify-player daemon";
    };
  };

  config = mkIf cfg.autostart {
    assertions = [{
      assertion = !(!cfg.enable && cfg.autostart);
      message = "cannot enable spotify-cli autostart without enabling spotify cli";
    }];

    systemd.user.services.spotify-player = {
      enable = true;
      description = "Spotify Player daemon";

      after = [ "network-online.target" "sound.target" ];
      wants = [ "network-online.target" "sound.target" ];
      wantedBy = [ "default.target" ];

      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.spotify-player}/bin/spotify_player -d";
        Restart = "always";
        RestartSec = "5";
        StartLimitBurst="5";
        StartLimitIntervalSec="60";
      };
    };
  };

}
