# Core System Modules

This directory contains fundamental NixOS system-level modules required by every host.

## Modules

| Module | Description |
|--------|-------------|
| `boot` | Bootloader and kernel configuration |
| `locale` | Timezone, keyboard layout, and language settings |
| `openssh` | SSH server configuration |
| `user` | User account management (groups, packages, shell) — see `user/` subdirectory |

## Usage

```nix
imports = with config.flake.modules.nixos; [ core ];
```
