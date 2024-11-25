{ config, myvars, ... }:

{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    ports = [ 22 ];

    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${myvars.username}" ]; 
      UseDns = true; # this from the default config, not sure what it does
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  #TODO import from keys.nix
  users.users.${myvars.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVeo7HfiwprBHKJC55YbFf7uLfd5+7bGw0KucZ+lIb+ ruven@W51195"
  ];
}

