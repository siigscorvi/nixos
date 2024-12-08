#  { pkgs, config, ... }:
# {
#   environment.systemPackages = with pkgs; [
# there exists a nixstore/.../xsessions/none+i3.desktop
#     tigervnc
#     virtualgl # not sure if necessary but keeping it for now
#     xorg.libXdamage
#     xorg.xinit
#   ];
#   systemd.services.vncserver = {
#     description = "System-wide TigerVNC server";
#     after = [ "network.target" "display-manager.service" ];
#     wantedBy = [ "multi-user.target" ];
#     serviceConfig = {
#       # Run VNC server on :1 with specified geometry and depth
#       Environment = "PATH=${pkgs.tigervnc}/bin:${pkgs.xorg.xinit}/bin:${pkgs.i3}/bin:/run/wrappers/bin:/usr/bin:/bin";
#
#       ExecStart = "${pkgs.tigervnc}/bin/vncserver :1 -geometry 1920x1080 -depth 24 -SecurityTypes None";
#       ExecStop = "${pkgs.tigervnc}/bin/vncserver -kill :1";
#       User = "siigs"; 
#       Group = "users";
#     };
#   };
# }
{}
