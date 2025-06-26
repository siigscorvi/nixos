{ pkgs, vars, lib, config, host, ... }:

with lib;
let
  cfg = config.programs.spotify-cli;
in
{
  options.programs.spotify-cli = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable spotify-player cli";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (spotify-player.override {
        withAudioBackend = "pulseaudio";
        withMediaControl = true;
        withImage = true;
        withDaemon = true;
        withNotify = true;
        withStreaming = true;
        # withSixel = true;
        withFuzzy = true;
      })
    ];

    home-manager.users.${vars.username} = {
      home.file.".config/spotify-player/app.toml" = {
        text = ''
        theme = "my_theme"
        client_id = "f38ad24aea4843f2baa8694c900929d1"
        client_port = 56712
        login_redirect_uri = "http://127.0.0.1:8989/login"
        playback_format = """
        {status} {track} • {artists}
        {album}
        {metadata}"""
        notify_timeout_in_secs = 0
        tracks_playback_limit = 50
        app_refresh_duration_in_ms = 32
        playback_refresh_duration_in_ms = 0
        page_size_in_rows = 20
        play_icon = "▶"
        pause_icon = "▌▌"
        liked_icon = "♥"
        border_type = "Rounded"
        progress_bar_type = "Rectangle"
        cover_img_length = 9
        cover_img_width = 5
        cover_img_scale = 1.0
        enable_media_control = true
        enable_streaming = "DaemonOnly"
        enable_notify = true
        enable_cover_image_cache = true
        default_device = "spotify-player@moses"
        notify_streaming_only = true
        seek_duration_secs = 5
        sort_artist_albums_by_type = false

        [notify_format]
        summary = "Now playing: {track}"
        body = "{artists} · {album}"

        [layout]
        playback_window_position = "Top"
        playback_window_height = 6

        [layout.library]
        playlist_percent = 40
        album_percent = 40

        [device]
        name = "spotify-player@${host.hostname}"
        device_type = "speaker"
        volume = 70
        bitrate = 320
        audio_cache = false
        normalization = false
        autoplay = true
        '';
      };

      home.file.".config/spotify-player/theme.toml" = {
        text = ''
          [[themes]]
          name = "my_theme"
          [themes.palette]
          background = "${config.theming.colors.bg}"
          foreground = "${config.theming.colors.fg}"
          black = "${config.theming.colors.bg0_h}"
          red = "${config.theming.colors.red1}"
          green = "${config.theming.colors.green1}"
          yellow = "${config.theming.colors.yellow1}"
          blue = "${config.theming.colors.blue1}"
          magenta = "${config.theming.colors.purple1}"
          cyan = "${config.theming.colors.aqua1}"
          white = "${config.theming.colors.fg2}"
          bright_black = "${config.theming.colors.gray2}"
          bright_red = "${config.theming.colors.red2}"
          bright_green = "${config.theming.colors.green2}"
          bright_yellow = "${config.theming.colors.yellow2}"
          bright_blue = "${config.theming.colors.blue2}"
          bright_magenta = "${config.theming.colors.purple2}"
          bright_cyan = "${config.theming.colors.aqua2}"
          bright_white = "${config.theming.colors.fg0}"
        '';
      };
    };
  };
}

