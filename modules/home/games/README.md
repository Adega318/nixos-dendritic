# Gaming Modules

This directory contains Home Manager modules for gaming software. Each file exposes `flake.modules.homeManager.<name>` — import individually (there is no aggregator).

## Modules

| Module | File | Description |
|--------|------|-------------|
| `heroic` | `heroic.nix` | Heroic Games Launcher (Epic/GOG) |
| `lutris` | `lutris.nix` | Lutris open gaming platform |
| `minecraft` | `minecraft.nix` | Minecraft (Prism Launcher / official launcher) |
| `ff14` | `ff14.nix` | Final Fantasy XIV (XIVLauncher) |
| `retroarch` | `retroarch.nix` | RetroArch multi-system emulator |
| `veloren` | `veloren.nix` | Veloren voxel RPG |
| `ryujinx` | `ryujinx.nix` | Ryujinx Nintendo Switch emulator |

> System-level gaming prerequisites (udev rules, Gamemode, etc.) live in `modules/nixos/desktop/games.nix` (part of the `desktop` aggregator).

## Usage

```nix
# modules/hosts/sam/home.nix — sam enables 6 of 7 (no retroarch)
imports = with config.flake.modules.homeManager; [
  ff14
  heroic
  lutris
  minecraft
  ryujinx
  veloren
  # retroarch # available but not enabled on any host
];

# modules/hosts/dean/home.nix — dean enables a subset
imports = with config.flake.modules.homeManager; [
  heroic
  lutris
];
```

To add a new game: create `modules/home/games/my-game.nix` with `flake.modules.homeManager.my-game = { pkgs, ... }: { home.packages = with pkgs; [ my-game ]; };` — it is auto-discovered.
