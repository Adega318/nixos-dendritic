{ config, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.nixos.podman =
    { pkgs, config, ... }:
    {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = !config.virtualisation.docker.enable;
          defaultNetwork.settings.dns_enabled = true;
        };
        containers.registries.settings.registry = [
          {
            location = "docker.io";
          }
        ];
        oci-containers.backend = "podman";
      };

      users.extraGroups.podman.members = [ flakeConfig.user.username ];

      environment = {
        systemPackages = with pkgs; [
          dive # look into docker image layers
          podman-tui # status of containers in the terminal
          podman-desktop # desktop app for podman
          kubectl
          podman-compose
        ];
        sessionVariables = {
          PODMAN_COMPOSE_WARNING_LOGS = "false";
        };
      };
    };
}
