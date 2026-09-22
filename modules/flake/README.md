# Flake Infrastructure Modules

This directory implements the flake's output wiring. It is bootstrapped by [`flake.nix:62`](../../flake.nix#L62) via `inputs.import-tree ./modules`, which recursively discovers every `.nix` file under `modules/` as a flake-parts module — no manual `imports` list required.

## Files

| File | Purpose |
|------|---------|
| `flake-parts.nix` | Enables `inputs.flake-parts.flakeModules.modules` so `flake.modules.*` is available. |
| `nixos.nix` | Declares `options.configurations.nixos` (`lazyAttrsOf (submodule { system, stateVersion, allowUnfree, wallpaper, base16Scheme, module })`) and generates `flake.nixosConfigurations` via `lib.nixosSystem`. Injects Stylix image/scheme, `nixpkgs.hostPlatform`, `nix` settings ( `pipe-operators nix-command flakes`, weekly GC), and `networking.hostName`. Also exposes `checks."configurations:nixos:<name>"`. |
| `home.nix` | Declares `options.configurations.homeManager` (`{ module }`) and generates `flake.homeConfigurations` via `home-manager.lib.homeManagerConfiguration`. Pulls `system`/`allowUnfree`/`wallpaper`/`base16Scheme` from the matching `configurations.nixos.<name>` host, injects matching Stylix module, and sets `home.username`/`homeDirectory`/`stateVersion`. Also exposes `checks."configurations:home:<name>"`. |
| `stylix.nix` | Defines the shared `stylix` function (dark polarity, `Bibata-Modern-Ice` cursor size 20, `Agave Nerd Font` serif/sans/mono, `Noto Color Emoji`). Publishes `flake.modules.nixos.stylix` and `flake.modules.homeManager.stylix` (the latter adds `stylix.targets` for `firefox`/`librewolf`/`zen-browser` on `default` profile). |
| `formatter.nix` | `perSystem.formatter = pkgs.nixfmt` → `nix fmt`. |
| `systems.nix` | `systems = [ "x86_64-linux" "aarch64-linux" ]` consumed by flake-parts `perSystem`. |
| `variables.nix` | Declares read-only options `user.username`, `user.email`, `user.hashedPassword`, `rootHashedPassword` (values live in [`modules/hosts/variables.nix`](../hosts/variables.nix)). |
| `sops.nix` | Enables `sops-nix` NixOS module, installs `sops`, `age`, `ssh-to-age`; configures SSH host key as age recipient and references encrypted secrets in `../../secrets/auth.yaml` for root/user passwords. |

## Dendritic Pattern

```
flake.nix  ──import-tree──►  modules/**/*.nix  ──flake-parts merge──►  config.flake.*
                                                        │
                              configurations.nixos.<host> + configurations.homeManager.<host>
                                                        ▼
                                           nixosConfigurations / homeConfigurations
```

1. `import-tree ./modules` reads every `.nix` file under `modules/` and returns them as a single flake-parts module.
2. `flake-parts` merges all discovered modules, making their `config.flake.*` outputs (notably `flake.modules.nixos.*` and `flake.modules.homeManager.*`) available to each other in the same evaluation.
3. `nixos.nix` / `home.nix` iterate over the user-defined `configurations.*` attrsets to materialize the final configurations. Adding a new `.nix` file anywhere in `modules/nixos/` or `modules/home/` makes it immediately importable via `with config.flake.modules.*` inside a host's `module.imports`.

## Adding a New Flake Output

Create a `.nix` file here that contributes to `flake.*` via flake-parts (e.g., `flake.checks`, `flake.packages`, `perSystem.*`). It will be auto-discovered. For reusable NixOS/Home Manager modules, prefer `modules/nixos/` or `modules/home/` instead.
