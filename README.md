# nixos-dendritic

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos&logoColor=white)](https://nixos.org)
[![flake-parts](https://img.shields.io/badge/built%20with-flake--parts-7a4c9d)](https://github.com/hercules-ci/flake-parts)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

Adega's personal NixOS configuration using a **dendritic** (tree-based) module discovery pattern built on top of [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

Modules placed anywhere under `modules/` are automatically discovered and made available — no manual import lists needed. Each host declares which modules it wants via `config.flake.modules.nixos.*` / `config.flake.modules.homeManager.*`.

## Hosts

| Host | Type | Hardware | Desktop | Enabled NixOS Modules | Enabled Home Modules |
| ------ | ------ | ---------- | --------- | ----------------------- | ---------------------- |
| `sam` | Desktop | AMD CPU/GPU | KDE Plasma 6 (SDDM Astronaut) | `core`, `desktop`, `kde`, `bluetooth`, `docker`, `podman`, `plymouth`, `wacom`, `tailscale` | `bottles`, `discord`, `easyeffects`, `gtk`, `iptv`, `latex`, `librewolf`, `plasma-manager`, `udiskie`, `opencode`, `dev` (incl. `nixvim`), `ff14`, `heroic`, `lutris`, `minecraft`, `ryujinx`, `veloren`, `calibre`, `obsidian`, `onlyoffice` + `home.packages` (`winboat`, `authenticator`, `nextcloud-client`, `portfolio`, `yacreader`, `dbeaver-bin`, `qbittorrent-enhanced`, `teams-for-linux`, `bruno`, `chromium`, `krita`, `ventoy`, `bitwarden-desktop`) |
| `dean` | Laptop | AMD CPU/GPU | KDE Plasma 6 (SDDM Astronaut) | `core`, `desktop`, `kde`, `fingerprint`, `bluetooth`, `docker`, `podman`, `plymouth`, `tailscale` | `bottles`, `discord`, `easyeffects`, `gtk`, `librewolf`, `plasma-manager`, `udiskie`, `opencode`, `dev` (incl. `nixvim`), `heroic`, `lutris`, `obsidian`, `onlyoffice` + `home.packages` (`winboat`, `nextcloud-client`, `yacreader`, `portfolio`, `dbeaver-bin`, `qbittorrent-enhanced`, `teams-for-linux`, `bruno`, `bitwarden-desktop`) + `plasma-manager.layouts = [{ layout = "es"; }]` |
| `castiel` | Server | — | — | *Planned — not yet configured* | *Planned* |

Wallpapers and base16 schemes are per-host (`wallpaper`, `base16Scheme`) — see [`wallpapers/`](./wallpapers/README.md).

## Features

- **Dendritic module discovery** — drop a `.nix` file anywhere in `modules/` and it is automatically imported via `import-tree`; exposed as `flake.modules.nixos.*` / `flake.modules.homeManager.*` without touching `flake.nix`.
- **Per-host configuration** — separate `configuration.nix` + `home.nix` + `hardware-configuration.nix` per machine; shared variables in [`modules/hosts/variables.nix`](./modules/hosts/README.md#variable-management).
- **Declarative theming via [Stylix](https://github.com/danth/stylix)** — dark polarity, Agave Nerd Font, Bibata-Modern-Ice cursor, Noto Color Emoji; per-host `wallpaper` + `base16Scheme` (`gruvbox-dark-hard`, `catppuccin-mocha`, `tokyo-night-dark`) with Firefox/Librewolf/Zen targets.
- **Home Manager** — user-level packages and dotfiles; defined alongside NixOS via `configurations.homeManager.<host>.module`.
- **Neovim (Nixvim)** — fully customized editor with ~15 LSP servers, `conform` formatting, `nvim-lint`, Telescope, Gitsigns/LazyGit, `opencode` integration, and polished UI (`noice`, `lualine`, `bufferline`, `which-key`) — see [`modules/home/dev/nixvim/README.md`](./modules/home/dev/nixvim/README.md).
- **KDE Plasma 6** — declarative desktop via [plasma-manager](https://github.com/nix-community/plasma-manager) + SDDM Astronaut theme; GNOME and COSMIC modules also available.
- **Developer tooling** — Zsh, Alacritty, Zed, Git, Direnv, Zoxide, Antigravity, Opencode CLI.
- **Secret management via [sops-nix](https://github.com/Mic92/sops-nix)** — SSH host key as age recipient; encrypted secrets in `secrets/auth.yaml` for root/user passwords; `sops`, `age`, `ssh-to-age` in systemPackages.
- **Gaming** — Lutris, Heroic Games Launcher, Minecraft, FF14, Veloren, Ryujinx (Switch) + system-level `games` (Steam udev rules, Gamemode); `retroarch` available but not enabled on any host.
- **Productivity** — Obsidian, Calibre, OnlyOffice, Bottles, Discord, Firefox/Librewolf/Zen.
- **Container & VM support** — Docker (with `dive` + `docker-compose`), rootless Podman (with `podman-tui`/`podman-compose`), optional `vm` module (libvirtd + VirtualBox).
- **Networking & services** — NetworkManager, PipeWire, Tailscale (nftables), Plymouth silent boot, Bluetooth, Wacom, power management.
- **Flake-parts** — modular, composable flake architecture with `nix fmt` (`nixfmt`) and `nix flake check` build checks for every host.

## Structure

```
.
├── flake.nix                  # Inputs (nixpkgs, nixos-hardware, home-manager, flake-parts, import-tree, stylix, plasma-manager, nixvim, antigravity-nix, recuncho, zen-browser, colibri, sops-nix) + import-tree ./modules
├── flake.lock
├── LICENSE
├── modules/
│   ├── flake/                 # Flake-level outputs — see modules/flake/README.md
│   │   ├── flake-parts.nix    # Enables flake-parts flakeModules.modules
│   │   ├── nixos.nix          # Defines configurations.nixos option → nixosConfigurations
│   │   ├── home.nix           # Defines configurations.homeManager option → homeConfigurations
│   │   ├── stylix.nix         # Declarative theming (NixOS + Home Manager modules)
│   │   ├── formatter.nix      # perSystem.formatter = nixfmt
│   │   ├── systems.nix        # [ x86_64-linux aarch64-linux ]
│   │   ├── variables.nix      # Options: user.username, user.email, user.hashedPassword, rootHashedPassword
│   │   └── sops.nix           # sops-nix + age/ssh-to-age; secrets in ../../secrets/auth.yaml
│   ├── hosts/                 # Per-host machine configs — see modules/hosts/README.md
│   │   ├── variables.nix      # Values for user.* + rootHashedPassword (adega)
│   │   ├── sam/               # Desktop: configuration.nix, home.nix, hardware-configuration.nix
│   │   ├── dean/              # Laptop:  configuration.nix, home.nix, hardware-configuration.nix
│   │   └── castiel/           # Server (placeholder — directory not yet created)
│   ├── nixos/                 # Shared NixOS system modules — see modules/nixos/README.md
│   │   ├── core/              # Boot (systemd-boot, limit 10), locale, openssh, user/{groups,packages,shell}
│   │   ├── desktop/           # audio (PipeWire), dconf, games, network, power (power-profiles-daemon), udisk (udisks2+gvfs+polkit), xdg + fingerprint (fprintd, standalone)
│   │   │   └── desktopManager/# kde (Plasma 6 + SDDM Astronaut), gnome, cosmic
│   │   ├── services/          # tailscale (nftables), ollama (vulkan), recuncho
│   │   ├── bluetooth.nix
│   │   ├── colibri.nix        # Colibri (via colibri flake input)
│   │   ├── docker.nix
│   │   ├── podman.nix
│   │   ├── plymouth.nix       # Silent boot
│   │   ├── vm.nix             # libvirtd + VirtualBox
│   │   └── wacom.nix
│   └── home/                  # Home Manager user modules — see modules/home/README.md
│       ├── dev/               # alacritty, git, zsh, zoxide, direnv, zed, antigravity, common-packages (+gnumake), nixvim
│       │   └── nixvim/        # Full Nixvim IDE — see modules/home/dev/nixvim/README.md
│       ├── games/             # lutris, heroic, minecraft, ff14, retroarch, veloren, ryujinx (retroarch available but not enabled)
│       ├── office/            # calibre, obsidian, onlyoffice
│       ├── bottles.nix
│       ├── discord.nix
│       ├── easyeffects.nix    # EasyEffects rnnoise preset
│       ├── firefox.nix        # (available — not enabled on any host)
│       ├── gtk.nix
│       ├── iptv.nix           # iptvnator + mpv
│       ├── latex.nix          # texstudio + texlive (scheme-basic, moderncv, pgf, …)
│       ├── librewolf.nix
│       ├── opencode.nix
│       ├── plasma-manager.nix
│       ├── udiskie.nix
│       └── zen.nix            # (available — not enabled on any host)
├── secrets/                   # sops-encrypted secrets (auth.yaml) — gitignored, age recipients via SSH host keys
└── wallpapers/                # 7 images — see wallpapers/README.md (sam → linux_atari.png, dean → cat.png)
```

Additional per-directory READMEs: [`modules/flake/`](./modules/flake/README.md) · [`modules/hosts/`](./modules/hosts/README.md) · [`modules/nixos/`](./modules/nixos/README.md) · [`modules/nixos/core/`](./modules/nixos/core/README.md) · [`modules/nixos/desktop/`](./modules/nixos/desktop/README.md) · [`modules/nixos/services/`](./modules/nixos/services/README.md) · [`modules/home/`](./modules/home/README.md) · [`modules/home/dev/`](./modules/home/dev/README.md) · [`modules/home/dev/nixvim/`](./modules/home/dev/nixvim/README.md) · [`modules/home/games/`](./modules/home/games/README.md) · [`modules/home/office/`](./modules/home/office/README.md) · [`wallpapers/`](./wallpapers/README.md)

## Prerequisites

- NixOS with flakes enabled (`experimental-features = nix-command flakes pipe-operators` — already default via this flake's `nix.settings`).
- Git.
- For Home Manager standalone: `home-manager` on `PATH` (or `nix run home-manager`).

## Usage

### Apply system configuration

```bash
# Replace <host> with sam | dean
sudo nixos-rebuild switch --flake .#<host>
# First-time / without sudo cache:
# sudo nixos-rebuild boot --flake .#<host> && reboot
```

### Apply Home Manager only (standalone)

```bash
home-manager switch --flake .#<host>
# or via nix:
nix run home-manager -- switch --flake .#<host>
```

### Update flake inputs

```bash
nix flake update
# update a single input:
nix flake update nixpkgs
```

### Format all Nix files

```bash
nix fmt  # → nixfmt via modules/flake/formatter.nix
```

### Check flake integrity (builds all hosts)

```bash
nix flake check
# builds nixosConfigurations + homeConfigurations as checks
```

### Show outputs

```bash
nix flake show
```

## Secret Management

This configuration uses [sops-nix](https://github.com/Mic92/sops-nix) with [age](https://github.com/FiloSottile/age) for secret encryption. Secrets are stored in `secrets/auth.yaml` and decrypted at activation time using the SSH host key (`/etc/ssh/ssh_host_ed25519_key`) as an age recipient.

### Current secrets

| Secret | sopsFile | Used by |
|--------|----------|---------|
| `system/rootPassword` | `secrets/auth.yaml` | `users.users.root.initialHashedPassword` |
| `system/userPassword` | `secrets/auth.yaml` | `users.users.adega.initialHashedPassword` |

Defined in `modules/flake/sops.nix:16-19`.

### Editing secrets

```bash
# Edit existing secrets (opens \$EDITOR with decrypted content)
sops secrets/auth.yaml

# Or use the nix shell with sops available
nix shell nixpkgs#sops -c sops secrets/auth.yaml
```

### Adding a new secret

1. Add a new key to `secrets/auth.yaml`:
   ```yaml
   system/newSecret: "plaintext-value"
   ```

2. Encrypt it:
   ```bash
   sops --encrypt --in-place secrets/auth.yaml
   ```

3. Reference it in `modules/flake/sops.nix`:
   ```nix
   sops.secrets = {
     "system/newSecret".sopsFile = ../../secrets/auth.yaml;
   };
   ```

4. Use it in a NixOS module via `config.sops.secrets."system/newSecret".path` (a file containing the decrypted value).

### Adding a new host (key rotation)

When adding a new host, its SSH host key must be added as an age recipient:

1. Get the new host's SSH public key (after first boot):
   ```bash
   ssh-keyscan -t ed25519 <new-host> | ssh-to-age
   # Output: age1...
   ```

2. Add the recipient to `secrets/auth.yaml`:
   ```bash
   sops --add-age <age-recipient> secrets/auth.yaml
   ```

3. Re-encrypt all secrets for the new recipient set:
   ```bash
   sops --encrypt --in-place secrets/auth.yaml
   ```

4. Commit the updated `secrets/auth.yaml` and deploy to all hosts.

### Backup

**Backup your age private keys!** The SSH host private keys (`/etc/ssh/ssh_host_ed25519_key`) are the only way to decrypt secrets. If you lose them (e.g., reinstall without backup), you cannot recover the secrets.

Consider exporting age keys to a secure offline backup:
```bash
ssh-to-age -private < /etc/ssh/ssh_host_ed25519_key > ~/age-key-backup.txt
# Store ~/age-key-backup.txt securely (password manager, encrypted USB, etc.)
```

## Adding a new host

1. Create `modules/hosts/<name>/` with three files following `sam`/`dean` as templates:
   - `configuration.nix` — set `configurations.nixos.<name> = { stateVersion, wallpaper, base16Scheme, module = { imports = with config.flake.modules.nixos; [ ... ]; }; }`
   - `home.nix` — set `configurations.homeManager.<name> = { module = { imports = with config.flake.modules.homeManager; [ ... ]; }; }`
   - `hardware-configuration.nix` — generated via `nixos-generate-config --show-hardware-config`
2. The dendritic architecture discovers it automatically — no registration in `flake.nix` needed.
3. Test: `nix flake check` and `sudo nixos-rebuild dry-build --flake .#<name>`.

See [`modules/hosts/README.md`](./modules/hosts/README.md) for variable management.

## Adding a new module

Just create a `.nix` file anywhere under `modules/`:

```nix
# modules/nixos/my-service.nix
{
  flake.modules.nixos.my-service = { pkgs, ... }: {
    services.my-service.enable = true;
  };
}
# modules/home/my-tool.nix
{
  flake.modules.homeManager.my-tool = { pkgs, ... }: {
    programs.my-tool.enable = true;
  };
}
```

It is automatically available as `config.flake.modules.nixos.my-service` / `config.flake.modules.homeManager.my-tool` inside any host's `imports`. For aggregated modules (like `dev`, `core`, `desktop`), add an entry to the corresponding `default.nix` that re-exports submodules via `imports = with config.flake.modules.*`.

## Architecture

The flake is bootstrapped by `flake.nix:62` → `inputs.import-tree ./modules`. `import-tree` recursively imports every `.nix` file under `modules/` as a flake-parts module. `flake-parts` merges them, exposing `config.flake.modules.*`, `config.flake.nixosConfigurations`, and `config.flake.homeConfigurations` (generated in `modules/flake/nixos.nix:44` and `modules/flake/home.nix:19`).

`modules/flake/variables.nix` declares `user.*` options; `modules/hosts/variables.nix` provides the concrete values. Per-host `wallpaper` + `base16Scheme` flow into both NixOS and Home Manager via shared Stylix modules.

## License

MIT — see [LICENSE](./LICENSE).
