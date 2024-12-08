{ vars, ... }:

{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    ports = [ 22 ];

    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${vars.username}" ]; 
      UseDns = true; # this from the default config, not sure what it does
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  #TODO import from keys.nix
  users.users.${vars.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVeo7HfiwprBHKJC55YbFf7uLfd5+7bGw0KucZ+lIb+ ruven@W51195"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHid9tjWkf1B0yxTRJZbKIaajmbV8jW6dDu0ITKUwyPQ siigs@moses"
  ];
}
