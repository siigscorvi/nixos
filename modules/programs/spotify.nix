{ stable, ... }:

{
  environment.systemPackages = with stable; [
    spotify
  ];
}
