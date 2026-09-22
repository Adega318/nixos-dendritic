# Core System Modules

This directory contains fundamental NixOS modules required by every host. All are re-exported via the `core` aggregator (`modules/nixos/core/default.nix:3`).

## Modules

| Module | File | Description |
| -------- | ------ | ------------- |
| `boot` | `boot.nix` | `systemd-boot` with EFI variable support (`configurationLimit = 10`) |
| `locale` | `locale.nix` | `Europe/Madrid` timezone, `en_US.UTF-8` default + `es_ES.UTF-8` LC_* overrides, `es` XKB/layout + console keymap |
| `openssh` | `openssh.nix` | OpenSSH server (port 22, `PasswordAuthentication false`, `PermitRootLogin prohibit-password`, `X11Forwarding false`) + `cloudflared access ssh` proxy for `ssh-gitea.eadega.com` |
| `user` | `user/` | User accounts from `config.user.*` / `config.rootHashedPassword` (see below) |

### `user/` Submodules

| File | Module / Purpose |
| ------ | ------------------ |
| `user/default.nix` | Defines `flake.modules.nixos.user` — creates `users.users.root` and `users.users.<username>` (normal user) |
| `user/groups.nix` | Extra groups for the user (`wheel`, `networkmanager`) — static; feature-specific groups (e.g., `docker`) are added by their own modules |
| `user/packages.nix` | System-wide packages for the user |
| `user/shell.nix` | Default shell configuration |

> `config.user.*` options are declared in `modules/flake/variables.nix` and valued in `modules/hosts/variables.nix`. `core` does not set them — it only consumes them.

## Usage

Import the whole stack:

```nix
imports = with config.flake.modules.nixos; [ core ];
```

Or import individually:

```nix
imports = with config.flake.modules.nixos; [ boot locale openssh user ];
```

Every host (`sam`, `dean`) currently imports `core` as a baseline.
