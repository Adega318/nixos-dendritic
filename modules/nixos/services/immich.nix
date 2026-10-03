{
  flake.modules.nixos.immich = { config, lib, ... }: {
    options.immich = {
      domain = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Domain to expose Glances through Nginx.";
      };
      dir = lib.mkOption {
        type = lib.types.path;
        default = config.services.immich.mediaLocation;
      };
      openFirewall = lib.mkEnableOption "Open firewall.";
      openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
    };

    config = {
      services = {
        immich = {
          enable = true;
          inherit (config.glances) openFirewall;
          mediaLocation = config.immich.dir;

          database.enable = true;
        };

        nginx.virtualHosts = lib.mkIf (config.immich.domain != null) {
          ${config.immich.domain} = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:${toString config.services.immich.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;
              extraConfig = ''
                client_max_body_size 50000M;
                proxy_read_timeout   600s;
                proxy_send_timeout   600s;
                send_timeout         600s;
              '';
            };
          };
        };
      };

      networking.firewall.interfaces.${config.services.tailscale.interfaceName} =
        lib.mkIf config.immich.openTailscale
          {
            allowedTCPPorts = [
              config.services.immich.port
            ];
            allowedUDPPorts = [
              config.services.immich.port
            ];
          };

      users.users.immich.extraGroups = [
        "video"
        "render"
      ];

      systemd.tmpfiles.rules = [
        "d ${config.immich.dir} 0775 ${config.services.immich.user} ${config.services.immich.group} - -"
      ];
    };
  };
}
