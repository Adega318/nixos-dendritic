# Development Modules

This directory aggregates the developer environment. Every file here is auto-discovered as `flake.modules.homeManager.<name>` and the `dev` aggregator (`default.nix:3`) re-exports the full stack.

## Members

| Module | File | Description |
| -------- | ------ | ------------- |
| `nixvim` | `nixvim/` | Full Neovim IDE (Nixvim) with LSP, Telescope, Git, Opencode — see [`nixvim/README.md`](./nixvim/README.md) |
| `alacritty` | `alacritty.nix` | Alacritty terminal emulator (Stylix-aware) |
| `git` | `git.nix` | Git + Git LFS + `lazygit`; `user.name`/`user.email` from `config.user.*` |
| `zsh` | `zsh.nix` | Zsh shell + plugins/aliases |
| `zoxide` | `zoxide.nix` | Zoxide (smarter `cd`) |
| `direnv` | `direnv.nix` | Direnv + `nix-direnv` |
| `zed` | `zed.nix` | Zed editor |
| `antigravity` | `antigravity.nix` | Antigravity (via `antigravity-nix` input) |
| `common-packages` | `common-packages.nix` | Shared CLI packages: `python3`, `nixd`/`nixfmt`/`nil`, `jdk`/`maven`, `gnumake`, `p7zip`/`unzip`/`unrar`, `inetutils`/`dig`/`cloudflared`/`wget`, `tree`/`parted`/`ncdu`, `lynis` |

All members plus `nixvim` extra packages (`cargo`/`rustc`/`rustfmt`, `go`, `nil`/`nixd`, `ripgrep` from `nixvim/pkgs.nix`) are available when `dev` is imported.

## Usage

Import the full suite:

```nix
imports = with config.flake.modules.homeManager; [ dev ];
```

Or pick individual tools:

```nix
imports = with config.flake.modules.homeManager; [ git zsh nixvim ];
```

Both active hosts (`sam`, `dean`) import `dev` via `configurations.homeManager.<host>.module`.
