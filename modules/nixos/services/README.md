# System Services

This directory contains optional NixOS system services. Each file exposes a standalone module as `flake.modules.nixos.<name>` — import only what the host needs.

## Modules

| Module | File | Description |
|--------|------|-------------|
| `tailscale` | `tailscale.nix` | Tailscale mesh VPN + `systemd-resolved`. Enables `services.tailscale` (`openFirewall`, `--accept-dns=true`), configures `networking.nftables` + `firewall.trustedInterfaces = [ "tailscale0" ]` / `allowedUDPPorts`, sets `TS_DEBUG_FIREWALL_MODE=nftables`, and disables `systemd.network.wait-online`. Adds `pkgs.tailscale` to `environment.systemPackages`. Enabled on both `sam` and `dean`. |
| `ollama` | `ollama.nix` | Ollama LLM server. Declares `options.ollama.acceleration` (default `pkgs.ollama-vulkan`) and sets `services.ollama = { enable = true; package = config.ollama.acceleration; }`. Not currently enabled on any host; import `ollama` to enable, or override `ollama.acceleration` (e.g., `ollama-rocm`, `ollama-cuda`). |
| `recuncho` | `recuncho.nix` | Recuncho self-hosted service from `inputs.recuncho` (`git+https://gitea.eadega.com/adega/recuncho`). Imports `inputs.recuncho.nixosModules.default` and sets `services.recuncho.enable = true`. Not currently enabled; import `recuncho` to enable. Requires `recuncho` flake input (already in `flake.nix`). |

## Usage

```nix
# modules/hosts/sam/configuration.nix
module.imports = with config.flake.modules.nixos; [
  tailscale
  # ollama   # optional — enable per host
  # recuncho # optional
];
```

To add a new service: create `modules/nixos/services/my-service.nix` with `flake.modules.nixos.my-service = { ... }: { services.my-service.enable = true; };`. It is auto-discovered via `import-tree`.
