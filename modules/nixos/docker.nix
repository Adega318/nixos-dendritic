{ config, ... }:
{
  flake.modules.nixos.docker =
    { pkgs, ... }:
    {
      virtualisation.docker.enable = true;

      users.extraGroups.docker.members = [ config.user.username ];

      environment.systemPackages = with pkgs; [
        dive # look into docker image layers
        docker-compose # start group of containers for dev
        lazydocker
      ];
    };
}
