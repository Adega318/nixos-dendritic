{
  flake.modules.nixos.tailscale =
    { config, pkgs, ... }:
    {
      services.tailscale.enable = true;

      networking = {
        nftables.enable = true;
        firewall = {
          trustedInterfaces = [ config.services.tailscale.interfaceName ];
          allowedUDPPorts = [ config.services.tailscale.port ];
        };
      };

      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
      systemd.network.wait-online.enable = false;
      boot.initrd.systemd.network.wait-online.enable = false;

      environment.systemPackages = [ pkgs.tailscale ];
    };
}
