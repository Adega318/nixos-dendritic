{
  flake.modules.nixos.nginx = { config, lib, ... }: {
    options.nginx.ports = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      description = "List of open ports";
    };

    config = {
      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedZstdSettings = true;
        recommendedBrotliSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedUwsgiSettings = true;
      };

      networking.firewall.allowedTCPPorts = config.nginx.ports;
    };
  };
}
