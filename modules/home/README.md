# Home Manager Modules

This directory contains Home Manager modules that configure user-level applications and environments.

## Directory Structure

- `dev/`: Development tools and environments (Alacritty, Git, Zsh, Zoxide, Direnv, Zed, Nixvim, Antigravity, common-packages).
  - `nixvim/`: A fully featured Neovim with LSP, Telescope, Git, Copilot Chat — see [`./dev/nixvim/README.md`](./dev/nixvim/README.md).
- `games/`: Gaming software (Lutris, Heroic, Minecraft, FF14, Retroarch, Veloren).
- `office/`: Productivity suites (Calibre, Obsidian, OnlyOffice).

## Standalone Modules

| Module | Description |
|--------|-------------|
| `bottles` | Run Windows software in containers |
| `discord` | Popular chat and community platform |
| `firefox` | Web browser configuration |
| `gtk` | GTK application theming |
| `librewolf` | Privacy-focused Firefox fork |
| `opencode` | Opencode CLI configuration |
| `plasma-manager` | Declarative KDE Plasma configuration |
| `udiskie` | Automatic removable disk mounting |
| `zen` | Zen browser configuration |

## Usage

These modules are automatically discovered and can be imported into your home configuration at `modules/hosts/<host>/home.nix` using the dendritic pattern:

```nix
imports = with config.flake.modules.homeManager; [
  dev
  games
  firefox
  discord
  # ...
];
```
