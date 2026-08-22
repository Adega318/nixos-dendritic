# Desktop Environment Modules

This directory contains modules for graphical desktop environments, hardware optimizations, and desktop peripherals.

## Modules

| Module | Description |
|--------|-------------|
| `audio` | Pipewire audio server and tools |
| `dconf` | Dconf system integration |
| `network` | NetworkManager connectivity |
| `power` | Power management for laptops and desktops |
| `udisk` | Automatic volume mounting via udisks2 |
| `xdg` | XDG Desktop Portal compatibility |
| `games` | Gaming-related system requirements |

## Desktop Managers

Available under `desktopManager/`:

| Module | Description |
|--------|-------------|
| `kde` | KDE Plasma 6 with custom SDDM (Astronaut theme) |
| `gnome` | GNOME desktop environment |
| `cosmic` | COSMIC desktop environment (Pop!_OS) |

## Usage

```nix
imports = with config.flake.modules.nixos; [
  desktop
  kde   # or gnome / cosmic
];
```
