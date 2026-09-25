{
  flake.modules.nixos.glances = { config, lib, ... }: {
    options.glances = {
      domain = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Domain to expose Glances through Nginx.";
      };
      openFirewall = lib.mkEnableOption "Open firewall.";
      openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
    };

    config = {
      services = {
        glances = {
          enable = true;
          inherit (config.glances) openFirewall;
        };

        nginx.virtualHosts = lib.mkIf (config.glances.domain != null) {
          ${config.glances.domain} = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:${toString config.services.glances.port}";
              proxyWebsockets = true;
            };
          };
        };
      };

      networking.firewall.interfaces.tailscale0.allowedTCPPorts = lib.mkIf config.glances.openTailscale [
        config.services.glances.port
      ];
    };
  };
}
