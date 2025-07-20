# {
#   services."06cb-009a-fingerprint-sensor" = {
#     enable = true;
#     backend = "python-validity";
#   };
#   systemd.services.python3-validity = {
#   serviceConfig = {
#     Restart = "always";
#     RestartSec = 2; # seconds to wait before restarting
#     after = [ "suspend.target" ];
#   };
# };
# }
