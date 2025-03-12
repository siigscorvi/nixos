{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.xsecurelock ];
  programs.xss-lock = {
    enable = true;
    extraOptions = [
      "-l"

    ];
    lockerCommand = "${pkgs.xsecurelock}/bin/xsecurelock";
  };
  
  # xsecurelock configuration
  environment.variables = {
    XSECURELOCK_AUTH_BACKGROUND_COLOR = "#282828";
    XSECURELOCK_AUTH_FOREGROUND_COLOR = "#fbf1c7";
    XSECURELOCK_AUTH_TIMEOUT = 30;
    XSECURELOCK_BLANK_TIMEOUT = 30;
    XSECURELOCK_FONT = "JetBrainsMonoNerdFont";
    XSECURELOCK_COMPOSITE_OBSCURER = 0;
  };

}
