{ vars, ... }:
{
  services.syncthing = {
    enable = true;
    group = "users";
    user = "${vars.username}";
    dataDir = "/home/${vars.username}/.syncthing";
    configDir = "/home/${vars.username}/.config/syncthing";
  };

}
