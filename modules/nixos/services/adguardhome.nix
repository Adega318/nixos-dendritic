{
  flake.modules.nixos.adguardhome =
    {
      config,
      lib,
      ...
    }:
    {
      options.adguardhome = {
        openFirewall = lib.mkEnableOption "Open firewall.";
        openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
      };

      config = {
        services.adguardhome = {
          enable = true;
          inherit (config.adguardhome) openFirewall;

          port = 3003;

          settings = {
            dns = {
              upstream_dns = [
                "https://dns.cloudflare.com/dns-query"
                "https://dns.quad9.net/dns-query"
              ];
              fallback_dns = [
                "9.9.9.9"
                "1.1.1.1"
              ];
              bootstrap_dns = [
                "9.9.9.9"
                "1.1.1.1"
              ];
              bind_hosts = [ "0.0.0.0" ];

              cache_enabled = true;
              cache_optimistic = true;
            };

            querylog = {
              enabled = true;
              interval = "7d";
              size_memory = 1000;
            };

            filtering = {
              protection_enabled = true;
              filtering_enabled = true;

              parental_enabled = false;
              safe_search.enabled = false;

              response_ttl_secs = 86400;
            };

            filters =
              map
                (url: {
                  enabled = true;
                  inherit url;
                })
                [
                  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
                  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
                ];
          };
        };

        networking.firewall.interfaces.${config.services.tailscale.interfaceName} =
          lib.mkIf config.adguardhome.openTailscale
            {
              allowedTCPPorts = [
                config.services.adguardhome.port
              ];
              allowedUDPPorts = [
                config.services.adguardhome.port
              ];
            };
      };
    };
}
