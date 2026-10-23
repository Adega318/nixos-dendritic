# Modules

This configuration uses the [dendritic pattern](https://github.com/mightyiam/dendritic) where modules are auto-discovered via `import-tree`. Each `.nix` file is treated as a module that can contribute to the flake outputs.

## Directory Structure

```
modules/
├── flake/          # Flake-parts configuration and flake output definitions
├── hosts/          # Per-host NixOS and Home Manager configurations
├── nixos/          # NixOS system modules
└── home/           # Home Manager user modules
```

## flake/

Flake-parts modules that define how the flake is assembled:

- `flake-parts.nix` - flake-parts setup
- `nixos.nix` - NixOS configuration builder with options for system settings, theming, etc.
- `home.nix` - Home Manager configuration builder
- `stylix.nix` - Stylix theming integration for both NixOS and Home Manager
- `sops.nix` - SOPS secrets integration
- `formatter.nix` - Treefmt formatter configuration
- `systems.nix` - Supported systems
- `variables.nix` - User variables options

## hosts/

Host-specific configurations. Each host has a directory with:

- `configuration.nix` - Defines `configurations.nixos.<hostname>` with settings and imported modules
- `home.nix` - Home Manager configuration for the host
- `hardware-configuration.nix` - Hardware-specific configuration

### sam

Desktop configuration using SDDM + KDE Plasma, with services like Cockpit, Glances, Tailscale, and tools like Podman, Bluetooth, Plymouth.

### dean

Desktop configuration (see `modules/hosts/dean/` for details).

## nixos/

System-level modules organized by functionality:

### core/

Essential system configuration:

- `default.nix` - Core module aggregator
- `boot.nix` - Bootloader configuration
- `locale.nix` - Locale and timezone settings
- `openssh.nix` - SSH server configuration
- `user/` - User account setup (default.nix, packages.nix, shell.nix, groups.nix)

### desktop/

Desktop environment and related services:

- `default.nix` - Desktop module aggregator
- `audio.nix` - Audio configuration (PipeWire)
- `bluetooth.nix` - Bluetooth support
- `dconf.nix` - Dconf settings
- `displayManager/` - Display managers (gdm, sddm, cosmic-greeter, noctalia-greeter)
- `desktopManager/` - Desktop environments (gnome, kde, cosmic, noctalia)
- `fingerprint.nix` - Fingerprint reader support
- `games.nix` - Gaming-related system configuration
- `network.nix` - Networking configuration
- `plymouth.nix` - Plymouth boot splash
- `power.nix` - Power management
- `udisk.nix` - UDisks configuration
- `wacom.nix` - Wacom tablet support
- `xdg.nix` - XDG portals
- `apps/` - Desktop applications (bitwarden, proton, tuta)

### services/

Self-hosted/containerized services:

- `adguardhome.nix` - AdGuard Home DNS filtering
- `cockpit.nix` - Web-based system management
- `glances.nix` - System monitoring
- `immich.nix` - Photo management
- `nginx.nix` - Web server
- `nutritrace.nix` - Nutrition tracking service
- `ollama.nix` - Local LLM service
- `portainer.nix` - Container management UI
- `recuncho.nix` - Custom service
- `tailscale.nix` - Tailscale VPN

### Other

- `docker.nix` - Docker container runtime
- `podman.nix` - Podman container runtime
- `vm.nix` - Virtual machine support
- `colibri.nix` - Colibri integration

## home/

User-level modules managed by Home Manager:

### dev/

Development tools:

- `default.nix` - Dev module aggregator
- `git.nix` - Git configuration
- `zsh.nix` - Zsh shell configuration
- `alacritty.nix` - Alacritty terminal
- `zed.nix` - Zed editor
- `direnv.nix` - Direnv integration
- `zoxide.nix` - Zoxide smart cd
- `common-packages.nix` - Common development packages
- `antigravity.nix` - Antigravity integration
- `nixvim/` - Neovim configuration (modular)
- `opencode/` - OpenCode configuration with custom agents

### games/

Gaming applications:

- `heroic.nix`, `lutris.nix`, `minecraft.nix`, `retroarch.nix`, `ryujinx.nix`, `veloren.nix`, `ff14.nix`

### office/

Productivity/office tools:

- `anki.nix`, `calibre.nix`, `obsidian.nix`, `onlyoffice.nix`, `portfolio.nix`

### Other

- `firefox.nix`, `librewolf.nix`, `zen.nix` - Web browsers
- `discord.nix` - Discord client
- `bottles.nix` - Wine/Windows app manager
- `easyeffects.nix` - Audio effects
- `gtk.nix` - GTK theming
- `iptv.nix` - IPTV configuration
- `plasma-manager.nix` - KDE Plasma configuration via Home Manager
- `udiskie.nix` - Removable media automount
- `latex.nix` - LaTeX/TeX Live setup

## Adding New Modules

Since this uses the dendritic pattern with import-tree, any `.nix` file placed in `modules/` will be automatically imported. Modules can:

1. Contribute to flake outputs (like `flake.nixosConfigurations`, `flake.homeConfigurations`)
2. Define NixOS modules under `flake.modules.nixos.<name>`
3. Define Home Manager modules under `flake.modules.homeManager.<name>`
4. Define options and configure the system

Follow the existing patterns for consistency.
