#TODO: finish configuration with sops setup for JWT_SECRET
{
  flake.modules.nixos.nutritrace =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.nutritrace = {
        domain = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Domain to expose nutritrace through Nginx.";
        };
        dir = lib.mkOption {
          type = lib.types.path;
          default = "/var/lib/nutritrace";
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = "nutritrace";
          description = "The user nutritrace should run as.";
        };
        group = lib.mkOption {
          type = lib.types.str;
          default = "nutritrace";
          description = "The group nutritrace should run as.";
        };
        port = lib.mkOption {
          type = lib.types.port;
          default = 3001;
          description = "The port that nutritrace will listen on.";
        };
        openFirewall = lib.mkEnableOption "Open firewall.";
        openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
      };

      config = {
        virtualisation.oci-containers = {
          containers.nutritrace = {
            user = "${toString config.users.users.${config.nutritrace.user}.uid}:${
              toString config.users.groups.${config.nutritrace.group}.gid
            }";
            image = "ghcr.io/traceapps/nutritrace:latest";

            ports = [ "${config.nutritrace.port}:3001" ];

            volumes = [
              "${config.nutritrace.dir}/db:/data/db"
              "${config.nutritrace.dir}/uploads:/data/uploads"
            ];

            environment = {
              DB_PATH = "/data/db/nutritrace.db";
              UPLOADS_PATH = "/data/uploads";
              # IMPORTANT: Change this to a long random string
              JWT_SECRET = "change-me-to-a-long-random-string";
              # Optional: Set if accessing over plain HTTP on your LAN
              # INSECURE_COOKIES = "1";
            };

            autoStart = true;
          };
        };

        users = {
          groups.${config.nutritrace.group} = {
            gid = 993;
          };
          users.${config.nutritrace.user} = {
            uid = 993;
            isSystemUser = true;
            group = config.nutritrace.group;
            home = config.nutritrace.dir;
            createHome = false;
            shell = "${pkgs.shadow}/bin/nologin";
          };
        };

        systemd.tmpfiles.rules = [
          "d ${config.nutritrace.dir} 0775 ${config.nutritrace.user} ${config.nutritrace.group} - -"
          "d ${config.nutritrace.dir}/db 0775 ${config.nutritrace.user} ${config.nutritrace.group} - -"
          "d ${config.nutritrace.dir}/uploads 0775 ${config.nutritrace.user} ${config.nutritrace.group} - -"
        ];

        services.nginx.virtualHosts = lib.mkIf (config.nutritrace.domain != null) {
          ${config.nutritrace.domain} = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:${toString config.nutritrace.port}";
              proxyWebsockets = true;
            };
          };
        };

        networking.firewall = {
          allowedTCPPorts = lib.mkIf config.nutritrace.openFirewall [ config.nutritrace.port ];
          interfaces.${config.services.tailscale.interfaceName} = lib.mkIf config.nutritrace.openTailscale {
            allowedTCPPorts = [
              config.nutritrace.port
            ];
            allowedUDPPorts = [
              config.nutritrace.port
            ];
          };
        };
      };
    };
}
