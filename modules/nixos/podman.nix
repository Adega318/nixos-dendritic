{ config, ... }:
{
  flake.modules.nixos.podman =
    { pkgs, ... }:
    {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        containers.registries.search = [
          "docker.io"
        ];
        oci-containers.backend = "podman";
      };

      users.extraGroups.podman.members = [ config.user.username ];

      environment = {
        systemPackages = with pkgs; [
          dive # look into docker image layers
          podman-tui # status of containers in the terminal
          podman-desktop # desktop app for podman
          kubectl
          podman-compose
          lazydocker
        ];
        sessionVariables = {
          PODMAN_COMPOSE_WARNING_LOGS = "false";
        };
      };
    };
}
