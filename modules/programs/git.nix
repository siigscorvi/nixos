{ vars }:

{
  home-manager.users.${vars.username} = {

    programs.git = {
      enable = true;
      userEmail = "${vars.unimail}";
      userName = "${vars.gitusername}";
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        url = {
          "ssh://git@github.com:siigscorvi" = { 
            insteadOf = "https://github.com/siigscorvi";
          };
        };
      };
    };

  };
}
