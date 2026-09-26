{
  flake.modules.nixos.cockpit =
    {
      config,
      lib,
      pkgs,
      hostname,
      ...
    }:
    {
      options.cockpit = {
        domain = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Domain to expose Cockpit through Nginx.";
        };
        openFirewall = lib.mkEnableOption "Open firewall.";
        tailscaleName = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = hostname;
          description = "Name of the tailscale machine to access.";
        };
        openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
      };

      config = {
        services = {
          cockpit = {
            enable = true;
            plugins = with pkgs; [
              cockpit-files
              cockpit-machines
              cockpit-dockermanager
              cockpit-podman
            ];

            inherit (config.cockpit) openFirewall;
            allowed-origins = [
              "http://localhost:${toString config.services.cockpit.port}"
              "https://localhost:${toString config.services.cockpit.port}"
            ]
            ++ lib.optional (config.cockpit.domain != null) "https://${config.cockpit.domain}"
            ++ lib.optionals config.cockpit.openTailscale [
              "http://${config.cockpit.tailscaleName}:${toString config.services.cockpit.port}"
              "https://${config.cockpit.tailscaleName}:${toString config.services.cockpit.port}"
            ];
          };

          nginx.virtualHosts = lib.mkIf (config.cockpit.domain != null) {
            ${config.cockpit.domain} = {
              locations."/" = {
                proxyPass = "http://127.0.0.1:${toString config.services.cockpit.port}";
                proxyWebsockets = true;
              };
            };
          };
        };

        networking.firewall.interfaces.tailscale0.allowedTCPPorts = lib.mkIf config.cockpit.openTailscale [
          config.services.cockpit.port
        ];
      };
    };
}
