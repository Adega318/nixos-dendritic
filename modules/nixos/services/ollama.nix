{
  flake.modules.nixos.ollama =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.ollama = {
        acceleration = lib.mkOption {
          type = lib.types.package;
          default = pkgs.ollama-vulkan;
          description = "The specific Ollama acceleration package to use.";
        };
        openFirewall = lib.mkEnableOption "Open firewall.";
        openTailscale = lib.mkEnableOption "Open firewall on the Tailscale interface.";
      };

      config = {
        services.ollama = {
          enable = true;
          package = config.ollama.acceleration;
          inherit (config.ollama) openFirewall;
        };

        networking.firewall.interfaces.tailscale0.allowedTCPPorts = lib.mkIf config.ollama.openTailscale [
          config.services.ollama.port
        ];
      };
    };
}
