{ pkgs, vars, ... }:

{
  imports = [ ./starship.nix ];

  programs.zsh.enable = true;
  users.users.${vars.username}.shell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.${vars.username} = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;

      history = {
        append = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };

      autocd = true;
      autosuggestion = {
        enable = true;
        #highlight = "fg=#ff00ff,bg=cyan,bold,underline";
        strategy = [ "history" "completion" "match_prev_cmd" ];
      };
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';

      # aliases
      shellAliases = {
        # git
        gst = "git status";
        gc = "git commit";
        gp = "git push";
        ga = "git add";
        gd = "git diff";

        vi = "nvim";
        vim = "nvim";
        v = "nvim";
        lg = "lazygit";
        sp = "spotify_player";
        spp = "spotify_player playback";

      };
    };

  };

}
