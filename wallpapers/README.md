# Wallpapers

Collection of desktop wallpapers. The per-host `wallpaper` option in `modules/hosts/<host>/configuration.nix` points at one of these files; `base16Scheme` tints it via Stylix.

| File | Size | Used by | Preview |
|------|------|---------|---------|
| `cat.png` | — | `dean` (laptop, `gruvbox-dark-hard`) | Cat |
| `linux_atari.png` | — | `sam` (desktop, `gruvbox-dark-hard`) | Linux Atari |
| `gigant_cat.png` | — | — (available) | — |
| `hail_mary.png` | — | — (available) | — |
| `nix.png` | — | — (available) | — |
| `pragmata.png` | — | — (available) | — |
| `lucifer.png` | — | — (available, added 2026-08-26) | — |

Total: **7 images**.

## Usage

Set the wallpaper for a host via `configurations.nixos.<host>.wallpaper`:

```nix
# modules/hosts/sam/configuration.nix
configurations.nixos.sam = {
  wallpaper = ../../../wallpapers/linux_atari.png;
  base16Scheme = "gruvbox-dark-hard"; # or null for wallpaper-only
};
```

The value is a `lib.types.path` (see `modules/flake/nixos.nix:21`) and is injected as `stylix.image` for both NixOS and Home Manager (`modules/flake/nixos.nix:60` / `modules/flake/home.nix:36`).

To add a new wallpaper: drop the image in this directory, then reference it from a host's `configuration.nix`.
