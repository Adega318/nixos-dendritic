{
  flake.modules.nixos.portainer =
    {
      inputs,
      config,
      lib,
      ...
    }:
    {
      imports = [ inputs.portainer-on-nixos.nixosModules.portainer ];

      options.portainer = {
        domain = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Domain to expose Portainer through Nginx.";
        };
        openFirewall = lib.mkEnableOption "Open firewall.";
        openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
      };

      config = {
        services = {
          portainer = {
            enable = true;
            inherit (config.portainer) openFirewall;
          };

          nginx.virtualHosts = lib.mkIf (config.portainer.domain != null) {
            ${config.portainer.domain} = {
              locations."/" = {
                proxyPass = "https://127.0.0.1:${toString config.services.portainer.port}";
                proxyWebsockets = true;
              };
            };
          };
        };

        networking.firewall.interfaces.tailscale0.allowedTCPPorts =
          lib.mkIf config.portainer.openTailscale
            [
              config.services.portainer.port
            ];
      };
    };
}
