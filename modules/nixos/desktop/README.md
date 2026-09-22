# Desktop Environment Modules

This directory provides the graphical desktop stack. All core desktop modules are re-exported via the `desktop` aggregator (`modules/nixos/desktop/default.nix:3`); desktop managers (`kde`/`gnome`/`cosmic`) are standalone and must be chosen explicitly.

## Modules

| Module | File | Description |
| -------- | ------ | ------------- |
| `audio` | `audio.nix` | PipeWire (PulseAudio + JACK replacement) with ALSA/Pulse support |
| `dconf` | `dconf.nix` | Dconf + GSettings integration for GNOME/KDE settings |
| `network` | `network.nix` | NetworkManager |
| `power` | `power.nix` | Power management (`power-profiles-daemon` + `upower` + `powertop` disabled; `thermald` disabled; `cpuFreqGovernor = "powersave"`) |
| `udisk` | `udisk.nix` | `udisks2` + `gvfs` + `polkit` (Home Manager `udiskie` pairs with it) |
| `xdg` | `xdg.nix` | XDG Desktop Portal + MIME integration |
| `games` | `games.nix` | System-level gaming prerequisites (Steam udev rules, Gamemode, etc.) |
| `fingerprint` | `fingerprint.nix` | Fingerprint reader via `fprintd` (option `fingerprint.sudo`); standalone — **not** in `desktop` aggregator, enabled only on `dean` |

## Desktop Managers

Available under `desktopManager/` — **not** included in the `desktop` aggregator; import one explicitly:

| Module | File | Description |
| -------- | ------ | ------------- |
| `kde` | `desktopManager/kde.nix` | KDE Plasma 6 + SDDM (Astronaut theme with Stylix wallpaper/font), `xserver.enable`, plus KDE utilities: `discover`, `kcalc`, `kcharselect`, `kclock`, `kcolorchooser`, `kolourpaint`, `ksystemlog`, `sddm-kcm`, `kdiff3`, `isoimagewriter`, `filelight`, `partitionmanager`, `kamoso`, `hardinfo2`, `wayland-utils`, `wl-clipboard`, `vlc` (excludes `plasma-browser-integration`, `elisa`, `kate`, `kdepim-runtime`, `ktorrent`, `kmahjongg`, `kmines`, `kpat`, `ksudoku`, `konversation` via `environment.plasma6.excludePackages`) |
| `gnome` | `desktopManager/gnome.nix` | GNOME desktop |
| `cosmic` | `desktopManager/cosmic.nix` | COSMIC (System76 Pop!_OS) |

## Usage

```nix
imports = with config.flake.modules.nixos; [
  desktop   # audio + dconf + games + network + power + udisk + xdg
  kde       # or gnome / cosmic — pick one
];
```

Both active hosts (`sam`, `dean`) use `desktop` + `kde`. `gnome` and `cosmic` are available but not currently enabled on any host.

To create a new desktop-related module: add `modules/nixos/desktop/my-feature.nix` with `flake.modules.nixos.my-feature = { ... }: { ... };` and, if it should be part of the aggregator, add it to `modules/nixos/desktop/default.nix`.
