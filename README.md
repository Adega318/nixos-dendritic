# nixos-dendritic

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos&logoColor=white)](https://nixos.org)
[![flake-parts](https://img.shields.io/badge/built%20with-flake--parts-7a4c9d)](https://github.com/hercules-ci/flake-parts)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Adega318/nixos-dendritic?style=social)](https://github.com/Adega318/nixos-dendritic/stargazers)

NixOS and Home Manager configuration using the [dendritic](https://github.com/mightyiam/dendritic) pattern with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

## Structure

- **`flake.nix`** - Flake entry point using flake-parts with auto-import via `import-tree ./modules`
- **`modules/`** - All NixOS, Home Manager, and flake configuration modules organized in a dendritic style
- **`modules/flake/`** - Flake-parts module definitions (nixos, home-manager, sops, stylix, variables, formatter, systems)
- **`modules/hosts/`** - Host-specific configurations (`sam`, `dean`)
- **`modules/nixos/`** - NixOS system modules (core, desktop, services, etc.)
- **`modules/home/`** - Home Manager user modules
- **`secrets/`** - Encrypted secrets managed with [sops-nix](https://github.com/Mic92/sops-nix)
- **`wallpapers/`** - Wallpaper images used with [stylix](https://github.com/danth/stylix)
- **`.sops.yaml`** - SOPS encryption rules for secrets

## Hosts

| Host   | Description                  | Desktop               | State Version |
| ------ | ---------------------------- | --------------------- | ------------- |
| `sam`  | Desktop/laptop configuration | KDE Plasma (via SDDM) | 26.05         |
| `dean` | Desktop/laptop configuration | KDE Plasma (via SDDM) | 26.05         |

## Features

- **Dendritic pattern**: Auto-discovery of modules via `import-tree`
- **Secrets management**: Age-encrypted secrets with per-host access control via sops-nix
- **Theming**: Unified theming with Stylix (base16 schemes, wallpapers)
- **Home Manager**: User configuration built into flake outputs via flake-parts
- **Custom modules**: Organized by concern (core, desktop, services, dev tools, games, etc.)
- **Nix formatting**: nixfmt configured via flake-parts
- **Garbage collection**: Weekly GC removing generations older than 30 days

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled
- [age](https://github.com/FiloSottile/age) keys for decrypting secrets (keys configured in `.sops.yaml`)
- For deployment, access to the appropriate age private keys

## Usage

### Building a system

```bash
# Build NixOS configuration for a host
nixos-rebuild switch --flake .#sam
nixos-rebuild switch --flake .#dean
```

### Building Home Manager configuration standalone

```bash
home-manager switch --flake .#sam
home-manager switch --flake .#dean
```

### Formatting

```bash
nix fmt
```

### Checking the flake

```bash
nix flake check
```

## Configuration

### User settings

User information is defined in `modules/hosts/variables.nix`:

```nix
{
  user = {
    username = "adega";
    email = "eadegafernandez@gmail.com";
  };
}
```

### Adding a new host

1. Create host directory under `modules/hosts/<hostname>/`
2. Create `configuration.nix` defining `configurations.nixos.<hostname>` with `stateVersion`, `wallpaper`, `base16Scheme`, and `module`
3. Create `home.nix` for home-manager configuration if needed
4. Add hardware configuration as `hardware-configuration.nix`
5. Update `.sops.yaml` with age keys for the host if using host-specific secrets

### Secrets

Secrets are encrypted with sops. Place secrets under `secrets/` following the patterns in `.sops.yaml`:

- `secrets/<host>/...` - host-specific secrets
- `secrets/...` - shared secrets

## Community

<a href="https://star-history.com/#Adega318/nixos-dendritic&Date">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=Adega318/nixos-dendritic&type=Date&theme=dark" />
        <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=Adega318/nixos-dendritic&type=Date" />
        <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=Adega318/nixos-dendritic&type=Date" />
    </picture>
</a>

## License

[MIT](LICENSE) - Copyright (c) 2026 adega
