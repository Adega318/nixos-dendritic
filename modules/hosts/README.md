# Hosts

Host-specific configurations for different machines.

## sam

Primary desktop/laptop configuration.

**Configuration** (`sam/configuration.nix`):

- State version: `26.05`
- Wallpaper: `wallpapers/linux_atari.png`
- Base16 scheme: `gruvbox-dark-hard`
- Display manager: SDDM
- Desktop environment: KDE Plasma
- Enabled modules: bluetooth, plymouth, podman, wacom, core, desktop, bitwarden, proton, cockpit, glances, tailscale
- Special config: SSH proxy through cloudflared for gitea, Cockpit/Glances exposed via Tailscale

**Files:**

- `configuration.nix` - NixOS system configuration
- `home.nix` - Home Manager user configuration
- `hardware-configuration.nix` - Generated hardware configuration

## dean

Secondary host configuration.

**Configuration** (`dean/configuration.nix`):

- State version: `26.05`
- Wallpaper: `wallpapers/lighthouse.png`
- Base16 scheme: `catppuccin-mocha`
- Display manager: SDDM
- Desktop environment: KDE Plasma
- Enabled modules: bluetooth, plymouth, podman, core, desktop, fingerprint, bitwarden, proton, cockpit, glances, tailscale
- Special config: SSH proxy through cloudflared for gitea, Cockpit/Glances exposed via Tailscale

**Files:**

- `configuration.nix` - NixOS system configuration
- `home.nix` - Home Manager user configuration
- `hardware-configuration.nix` - Generated hardware configuration

## Adding a New Host

1. Create directory: `modules/hosts/<hostname>/`
2. Create `configuration.nix`:

```nix
{ config, ... }:
{
  configurations.nixos.<hostname> = {
    stateVersion = "XX.XX";
    wallpaper = ../../../wallpapers/your-wallpaper.png;
    base16Scheme = "gruvbox-dark-hard"; # or "catppuccin-mocha", "tokyo-night-dark", null
    module = {
      imports = with config.flake.modules.nixos; [
        # Import needed modules
        core
        desktop
        # ...
      ];
      # Host-specific config
    };
  };
}
```

1. Create `home.nix` for Home Manager config
2. Add `hardware-configuration.nix` (copy from the target system or generate with `nixos-generate-config`)
3. If using host-specific secrets, add age keys to `.sops.yaml`
4. Build with `nixos-rebuild switch --flake .#<hostname>`
