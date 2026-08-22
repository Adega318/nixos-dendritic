# nixos-dendritic

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos&logoColor=white)](https://nixos.org)
[![flake-parts](https://img.shields.io/badge/built%20with-flake--parts-7a4c9d)](https://github.com/hercules-ci/flake-parts)

Adega's personal NixOS configuration using a **dendritic** (tree-based) module discovery pattern built on top of [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

Modules placed anywhere under `modules/` are automatically discovered and made available — no manual import lists needed.

## Hosts

| Host | Type | Hardware | Desktop | Services |
|------|------|----------|---------|----------|
| `sam` | Desktop | AMD CPU/GPU | KDE | Docker, Podman, Bluetooth, Tailscale, Ollama, Plymouth, Wacom |
| `dean` | Laptop | Intel CPU/GPU | KDE | Podman, Bluetooth, Tailscale, Plymouth |
| `castiel` | Server | — | — | *Planned* |

## Features

- **Dendritic module discovery** — drop a `.nix` file anywhere in `modules/` and it's automatically imported
- **Per-host configuration** — separate `configuration.nix` + `home.nix` + `hardware-configuration.nix` per machine
- **Declarative theming** via [Stylix](https://github.com/danth/stylix) — dark theme, Agave Nerd Font, Bibata cursor, Firefox/Librewolf/Zen theme targets
- **Home Manager** — user-level package and dotfile management for every host
- **Neovim (Nixvim)** — fully customized editor with LSP, Telescope, Git, Copilot Chat, and polished UI — see [`nixvim`](./modules/home/dev/nixvim/README.md)
- **KDE Plasma** — declarative desktop configuration via [plasma-manager](https://github.com/nix-community/plasma-manager)
- **Gaming** — Lutris, Heroic Games Launcher, Minecraft, FF14, Retroarch, Veloren
- **Container runtimes** — Docker and rootless Podman
- **Flake-parts** — modular, composable flake architecture

## Structure

```
modules/
├── flake/              # Flake-level outputs (flake-parts wiring, formatter, systems, variables)
│   ├── flake-parts.nix # flake-parts integration
│   ├── home.nix        # Home Manager output generator
│   ├── nixos.nix       # NixOS configuration generator
│   ├── stylix.nix      # Declarative theming
│   ├── formatter.nix   # nix fmt (nixfmt)
│   ├── systems.nix     # Supported systems
│   └── variables.nix   # Shared options (username, email, stateVersion)
├── hosts/              # Per-host machine configurations
│   ├── sam/            # Desktop: configuration.nix, home.nix, hardware-configuration.nix
│   ├── dean/           # Laptop: configuration.nix, home.nix, hardware-configuration.nix
│   ├── castiel/        # Server (placeholder)
│   └── variables.nix   # Global variables shared across hosts
├── nixos/              # Shared NixOS system modules
│   ├── core/           # Boot, locale, SSH, user accounts
│   ├── desktop/        # Audio, networking, power, gaming, desktop managers
│   │   └── desktopManager/  # KDE, GNOME, COSMIC
│   ├── services/       # Tailscale, Ollama
│   ├── bluetooth.nix   # Bluetooth hardware support
│   ├── docker.nix      # Docker container engine
│   ├── podman.nix      # Rootless Podman
│   ├── plymouth.nix    # Boot splash screen
│   ├── vm.nix          # Virtualization support
│   └── wacom.nix       # Wacom tablet support
└── home/               # Home Manager user modules
    ├── dev/            # Developer tools (Alacritty, Git, Zsh, Zoxide, Direnv, Nixvim, Zed, Antigravity)
    ├── games/          # Gaming (Lutris, Heroic, Minecraft, FF14, Retroarch, Veloren)
    ├── office/         # Productivity (Calibre, Obsidian, OnlyOffice)
    ├── bottles.nix     # Windows software containers
    ├── discord.nix
    ├── firefox.nix
    ├── gtk.nix
    ├── librewolf.nix
    ├── opencode.nix
    ├── plasma-manager.nix
    ├── udiskie.nix
    └── zen.nix         # Zen browser

wallpapers/             # Desktop wallpapers (5 images) — see wallpapers/README.md
```

## Prerequisites

- NixOS with flakes enabled
- Nix command set to `experimental-features = pipe-operators nix-command flakes` (already default on NixOS)

## Usage

### Apply system configuration

```bash
# Replace <host> with sam, dean, or castiel
sudo nixos-rebuild switch --flake .#<host>
```

### Apply Home Manager only

```bash
home-manager switch --flake .#<host>
```

### Update flake inputs

```bash
nix flake update
```

### Format all Nix files

```bash
nix fmt
```

### Check flake integrity

```bash
nix flake check
```

## Adding a new host

1. Create a directory under `modules/hosts/<name>/`
2. Add `configuration.nix`, `home.nix`, and `hardware-configuration.nix`
3. The dendritic architecture automatically discovers the new host

## Adding a new module

Just create a `.nix` file anywhere under `modules/` and it will be automatically available via `config.flake.modules.nixos.<name>` (for `modules/nixos/`) or `config.flake.modules.homeManager.<name>` (for `modules/home/`).
