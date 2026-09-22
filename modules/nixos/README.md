# NixOS Modules

This directory contains NixOS system-level modules. Every `.nix` file here is auto-discovered via `import-tree` and exposed as `flake.modules.nixos.<name>` for use in `modules/hosts/<host>/configuration.nix`.

## Directory Structure

```
modules/nixos/
├── core/                   # Essential system config — see core/README.md
│   ├── default.nix         # Aggregator: flake.modules.nixos.core → [boot locale openssh user]
│   ├── boot.nix            # Bootloader + kernel
│   ├── locale.nix          # Timezone, keyboard, language
│   ├── openssh.nix         # SSH server
│   └── user/               # User accounts (groups, packages, shell)
│       ├── default.nix
│       ├── groups.nix
│       ├── packages.nix
│       └── shell.nix
├── desktop/                # Graphical stack — see desktop/README.md
│   ├── default.nix         # Aggregator: [audio dconf games network power udisk xdg] — fingerprint is standalone
│   ├── audio.nix           # PipeWire
│   ├── dconf.nix
│   ├── games.nix           # System-level gaming deps
│   ├── network.nix         # NetworkManager
│   ├── power.nix           # Power management (power-profiles-daemon, upower, powertop off)
│   ├── udisk.nix           # udisks2 + gvfs + polkit
│   ├── xdg.nix             # XDG portals
│   ├── fingerprint.nix     # Fingerprint (fprintd, optional sudo) — standalone, not in desktop aggregator
│   └── desktopManager/
│       ├── kde.nix         # KDE Plasma 6 + SDDM Astronaut (custom theme)
│       ├── gnome.nix
│       └── cosmic.nix      # COSMIC (Pop!_OS)
├── services/               # System services — see services/README.md
│   ├── tailscale.nix       # Tailscale mesh VPN (nftables, DNS, firewall)
│   ├── ollama.nix          # Ollama LLM server (configurable acceleration, default ollama-vulkan)
│   └── recuncho.nix        # Recuncho (via gitea.eadega.com/adega/recuncho input)
├── bluetooth.nix           # Bluetooth (powerOnBoot, FastConnectable, AutoEnable)
├── colibri.nix             # Colibri (inputs.colibri, v41_dsml backfill)
├── docker.nix              # Docker + dive + docker-compose; adds user to docker group
├── podman.nix              # Rootless Podman + dive/podman-tui/podman-compose
├── plymouth.nix            # Plymouth silent boot (quiet, consoleLogLevel 3)
├── vm.nix                  # Virtualization: libvirtd + VirtualBox (host+guest) + spiceUSBRedirection
└── wacom.nix               # Wacom tablet (xserver.digimend)
```

## Standalone vs Aggregator Modules

| Kind | Examples | Import As |
|------|----------|-----------|
| Standalone | `bluetooth`, `colibri`, `docker`, `podman`, `plymouth`, `vm`, `wacom`, `fingerprint`, `tailscale`, `ollama`, `recuncho`, `kde`/`gnome`/`cosmic` | `with config.flake.modules.nixos; [ bluetooth docker tailscale kde ]` |
| Aggregator | `core` (boot+locale+openssh+user), `desktop` (audio+dconf+games+network+power+udisk+xdg) | `with config.flake.modules.nixos; [ core desktop ]` |

Desktop managers and `fingerprint`/`colibri` are **not** part of `desktop` — import explicitly when needed (`kde`, `fingerprint` on `dean`).

## Usage

In `modules/hosts/<host>/configuration.nix`:

```nix
{ config, ... }:
{
  configurations.nixos.<host> = {
    stateVersion = "26.05";
    wallpaper = ../../../wallpapers/cat.png;
    base16Scheme = "gruvbox-dark-hard";
    module.imports = with config.flake.modules.nixos; [
      core
      desktop
      kde        # or gnome / cosmic
      bluetooth
      docker
      podman
      plymouth
      tailscale
      # ollama   # optional — not enabled by default
      # recuncho # optional
      # vm       # optional
      # wacom    # only sam
    ];
  };
}
```

Create a new module by adding `modules/nixos/my-module.nix`:

```nix
{
  flake.modules.nixos.my-module = { pkgs, config, ... }: {
    services.my-module.enable = true;
  };
}
```

It is immediately available as `config.flake.modules.nixos.my-module`.
