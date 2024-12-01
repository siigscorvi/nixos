{ myvars }:

{
  home-manager.users.${myvars.username} = {

    programs.git = {
      enable = true;
      userEmail = "${myvars.unimail}";
      userName = "${myvars.gitusername}";
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
