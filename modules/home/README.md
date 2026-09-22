# Home Manager Modules

This directory contains Home Manager modules (user-level applications and dotfiles). Every `.nix` file here is auto-discovered via `import-tree` and exposed as `flake.modules.homeManager.<name>` for use in `modules/hosts/<host>/home.nix`.

## Directory Structure

```
modules/home/
├── dev/                    # Developer environment — see dev/README.md
│   ├── default.nix         # Aggregator: flake.modules.homeManager.dev → [nixvim alacritty antigravity common-packages direnv git zed zoxide zsh]
│   ├── nixvim/             # Full Neovim IDE (Nixvim) — see dev/nixvim/README.md
│   ├── alacritty.nix       # Alacritty terminal
│   ├── git.nix             # Git (+ LFS) + lazygit, user.name/email from config.user
│   ├── zsh.nix             # Zsh shell
│   ├── zoxide.nix          # Zoxide (smarter cd)
│   ├── direnv.nix          # Direnv + nix-direnv
│   ├── zed.nix             # Zed editor
│   ├── antigravity.nix     # Antigravity (via antigravity-nix input)
│   └── common-packages.nix # Shared CLI: python3, nixd/nixfmt/nil, jdk/maven, gnumake, p7zip/unzip/unrar, inetutils/dig/cloudflared/wget, tree/parted/ncdu, lynis
├── games/                  # Gaming — see games/README.md (7 modules)
│   ├── heroic.nix          # Heroic Games Launcher
│   ├── lutris.nix
│   ├── minecraft.nix
│   ├── ff14.nix            # Final Fantasy XIV
│   ├── retroarch.nix       # (available — not enabled on any host)
│   ├── veloren.nix
│   └── ryujinx.nix         # Nintendo Switch emulator
├── office/                 # Productivity — see office/README.md (3 modules)
│   ├── calibre.nix
│   ├── obsidian.nix
│   └── onlyoffice.nix
├── bottles.nix             # Bottles — Windows software containers
├── discord.nix
├── easyeffects.nix         # EasyEffects rnnoise preset
├── firefox.nix             # (available — not enabled on any host)
├── gtk.nix                 # GTK theming (Stylix-aware)
├── iptv.nix                # iptvnator + mpv
├── latex.nix               # texstudio + texlive (scheme-basic, moderncv, pgf, …)
├── librewolf.nix           # Privacy-focused Firefox fork
├── opencode.nix            # Opencode CLI
├── plasma-manager.nix      # Declarative KDE Plasma (plasma-manager)
├── udiskie.nix             # Auto-mount removable disks
└── zen.nix                 # Zen browser (via zen-browser flake, not enabled on any host)
```

## Standalone Modules

| Module | Description | Notes |
| -------- | ------------- | ------- |
| `bottles` | Run Windows software via Bottles | |
| `discord` | Discord chat | |
| `easyeffects` | EasyEffects noise suppression | `rnnoise` preset; enabled on `sam`+`dean` |
| `firefox` | Firefox (Stylix target `firefox`) | Available — not enabled on any host |
| `gtk` | GTK theming | Complements Stylix |
| `iptv` | IPTV player | `iptvnator` + `mpv`; only `sam` |
| `latex` | LaTeX suite | `texstudio` + `texlive` (`scheme-basic`, `moderncv`, `pgf`, …); only `sam` |
| `librewolf` | Librewolf (Stylix target `librewolf`) | |
| `opencode` | Opencode CLI + Nixvim integration | See `dev/nixvim/utils/opencode.nix` |
| `plasma-manager` | Declarative KDE Plasma | Hosts also set `plasma-manager.layouts` |
| `udiskie` | `udiskie` automounter | Pairs with `nixos/desktop/udisk.nix` |
| `zen` | Zen Browser (Stylix target `zen-browser`) | Via `zen-browser` input; not enabled on any host |

## Aggregator Modules

| Aggregator | Members | Usage |
|------------|---------|-------|
| `dev` | `nixvim`, `alacritty`, `antigravity`, `common-packages`, `direnv`, `git`, `zed`, `zoxide`, `zsh` | `with config.flake.modules.homeManager; [ dev ]` pulls the entire dev stack; or import members individually |

## Usage

In `modules/hosts/<host>/home.nix`:

```nix
{ config, ... }:
{
  configurations.homeManager.<host>.module = { pkgs, ... }: {
    imports = with config.flake.modules.homeManager; [
      # Aggregators
      dev
      # Groups
      # games are imported individually (no aggregator)
      heroic
      lutris
      # Standalone
      firefox
      discord
      plasma-manager
      # ...
    ];
  };
}
```

No manual registration — just create `modules/home/my-tool.nix` with `flake.modules.homeManager.my-tool = { ... }: { ... };` and it becomes available.
