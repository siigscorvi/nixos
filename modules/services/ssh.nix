{ vars, keys, ... }:

{
  services.openssh = {
    enable = true;
    allowSFTP = true;

    ports = [ 22 ];

    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${vars.username}" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${vars.username}.openssh.authorizedKeys.keys = [
    "${keys.genesis-pub-ssh-key}"
    "${keys.moses-pub-ssh-key}"
  ];
}
