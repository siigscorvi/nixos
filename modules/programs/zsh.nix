{ pkgs, myvars }:

{
  import = [
    ./starship.nix
  ];

  users.users.${myvars.username}.shell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  
  home-manager.users.${myvars.username} = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;

      # options
      history = {
        append = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };

      # plugins
      autocd = true;
      autosuggestion = {
        enable = true;
        #highlight = "fg=#ff00ff,bg=cyan,bold,underline";
        strategy = [
          "history"
          "completion"
          "match_prev_cmd"
        ];
      };
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
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

        ff = "fastfetch";
        nhs = "nh os switch -H ${myvars.username} ~/.dotfiles/";
#      vnc0 = "x0vncserver -rfbauth ~/.config/tigervnc/passwd -Display=:0";
      };
    };

  };

}
