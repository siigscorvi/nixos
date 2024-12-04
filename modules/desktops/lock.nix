{pkgs, ... }:
{
  environment.systemPackages = [ pkgs.xsecurelock ];
  programs.xss-lock = {
    enable = true;
    extraOptions = [
      "-l"

    ];
    lockerCommand = "${pkgs.xsecurelock}/bin/xsecurelock";
  };
}
