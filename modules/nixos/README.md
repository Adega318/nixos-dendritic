# NixOS Modules

This directory contains NixOS system-level modules for core services, hardware support, and desktop environments.

## Directory Structure

- `core/`: Fundamental system configuration — bootloader, locale, SSH, user accounts.
- `desktop/`: Graphical environment, audio, networking, power, gaming, and desktop managers.
  - `desktopManager/`: KDE Plasma 6, GNOME, COSMIC
- `services/`: System services — Tailscale mesh VPN, Ollama LLM server.

## Standalone Modules

| Module | Description |
|--------|-------------|
| `bluetooth` | Enable and configure Bluetooth hardware |
| `docker` | Docker container engine and Docker Compose |
| `podman` | Rootless Podman container engine |
| `plymouth` | Boot splash screen configuration |
| `vm` | Virtualization support |
| `wacom` | Wacom tablet input support |

## Usage

Modules are automatically exposed via `config.flake.modules.nixos` and can be imported in `modules/hosts/<host>/configuration.nix`:

```nix
module.imports = with config.flake.modules.nixos; [
  core
  desktop
  kde       # or gnome / cosmic
  bluetooth
  tailscale
  # ...
];
```
